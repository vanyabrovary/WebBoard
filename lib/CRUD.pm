package CRUD;

use warnings;
use strict;

use String::Clean::XSS;

use DB;

sub new {
    my ( $class, $arg ) = @_;

    my $self = {};

    if ( $arg->{id} ) {
        $self = load( $class, $arg->{id} );
    }
    else {
        bless $self, $class;
    }

    $self->set($arg);

    return $self;
}

sub load {
    my ( $class, $val, $col ) = @_;

    $col ||= 'id';

    return 0 unless $val;

    my $self = ();

    $self = &_fetch_from_db( $class, $col, $val );

    return $self;
}

sub list {
    my ( $class, $val, $col ) = @_;

    my $use_class = 'CRUD/' . $class . '.pm';

    require $use_class;

    my $h = $db->prepare( "SELECT id FROM " . $class->db_table() . " WHERE " . ( $col || 'id' ) . " = ?" );
    $h->execute( $val || 0 );

    my @b = ();

    while ( my ($id) = $h->fetchrow_array ) {
        push @b, $class->load($id);
    }

    return \@b;
}

sub list_json {
    my ($class) = @_;

    my $h =
      $db->prepare( "SELECT "
          . join( ',', $class->db_columns() )
          . " FROM "
          . $class->db_table()
          . " ORDER BY "
          . $class->db_order );
    $h->execute();

    my @b = ();

    while ( my $l = $h->fetchrow_hashref ) {
        push @b, $l;
    }

    if ( !$#b ) {
        return 0;
    }
    else {
        return \@b;
    }
}

sub save {
    my $self = shift;

    $self->_store_in_db();

    return $self;
}

sub del {
    my $self = shift;

    $self->_delete_from_db();

    return $self;
}

sub set {
    my ( $self, $arg ) = @_;

    foreach my $col ( $self->db_columns ) {

        $self->{$col} = $arg->{$col} if defined $arg->{$col};

    }
    return 1;
}

sub newid {
    my $self = shift;
    return $db->{mysql_insertid} || $self->{id};
}

sub _fetch_from_db {
    my ( $cls, $col, $val ) = @_;

    my $h = $db->prepare(
        'SELECT ' . join( ',', $cls->db_columns() ) . ' FROM ' . $cls->db_table() . ' WHERE ' . $col . ' = ? ' );
    $h->execute($val);
    my $obj = $h->fetchrow_hashref();

    if ($obj) {
        return bless $obj, $cls;
    }
    else {
        return 0;
    }
}

sub _store_in_db {
    my $self = shift;

    my @binds = ();
    my @keys  = ();

    foreach my $key ( $self->db_columns ) {
        next unless defined $self->{$key};
        next if $key eq 'id';
        push @keys,  "$key = ?";
        push @binds, convert_XSS( $self->{$key} );
    }

    my $q = '';

    if ( $self->{id} ) {
        $q = 'UPDATE ' . $self->db_table . ' SET ' . join( ',', @keys ) . ' WHERE id = ?';
        push @binds, $self->{id};
    }
    else {
        $q = 'INSERT ' . $self->db_table . ' SET ' . join( ',', @keys ) . ' ';
    }

    my $h = $db->prepare($q);
    $h->execute(@binds) or do { return 0; };

    $self->{id} ||= $self->newid();

    return 1;
}

sub _delete_from_db {
    my $self = shift;

    return 0 unless $self->{id};

    my $sth = $db->prepare( 'DELETE FROM ' . $self->db_table . ' WHERE id = ?' );

    $sth->execute( $self->{id} ) or return 0;
}

=pod

=encoding UTF-8

=head1 NAME

CRUD - the simplest CRUD implementation for Perl

=head1 DESCRIPTION

CRUD implementation with full SQL syntax support.

Contain only methods needed for CRUD.

No JOIN or UNION implementation inside.

Mostly old scool Perl coding style using.

=head1 CRUD SAMPLE

=head2 feed CRUD

package CRUD::Feed;

use CRUD;

our @ISA = qw/CRUD/;

sub db_table()   { 'feed' };

sub db_columns() { qw/id name is_public updated created/ };

sub feed_file(){

    my $self = shift;

    use CRUD::FeedFile;

    $self->{feed_file} ||= CRUD::FeedFile->list_where( $self->{id}, 'feed_id' );

}

=head2 feed_file CRUD

package CRUD::FeedFile;

use CRUD;

our @ISA = qw/CRUD/;

sub db_table()   { 'feed_file' };

sub db_columns() { qw/id feed_id name size is_public for_date updated created/ };

sub feed(){

    my $self = shift;

    use CRUD::Feed;

    $self->{feed} ||= CRUD::Feed->load( $self->{feed_id} );

}

=head1 REQUESTS EXAMPLES

=head2 Create

my $CRUD = CRUD::Feed->new($args);

$CRUD->save();

=head2 Update

my $crud = CRUD::Feed->load( $arg->{id}, 'id' );

$crud->{name} = 'My new feed name';

$crud->save();

Or

my $crud = CRUD::Feed->load( $arg->{id} );

$crud->{name} = 'My new feed name';

$crud->save();

=head2 Read

my $crud = CRUD::Feed->load( $channel_id, 'channel_id' );

print Dumper($crud);

=head2 Read list.

print $_->{some_field} foreach ( @{ CRUD::Feed->list() } )

=head2 Read inner list.

foreach ( @{ CRUD::Feed->list() } ){

    print Dumper($_) foreach ( @{ $_->feed_file() } );

}

=head2 Read list where.

print $_->{name}." ".$_->{size}." ".$_->{updated} foreach ( @{ CRUD::FeedFile->list_where( $arg->{feed_id}, 'feed_id' ) } )

=head2 Delete.

my $crud = CRUD::FeedFileStat->load( $arg->{id} );

$crud->del();

=head1 BUGS

newid - return bad value for MySQL.

=head1 SUPPORT

Bugs may be submitted through vanyabrovaru@gmail.com

=cut

1;
