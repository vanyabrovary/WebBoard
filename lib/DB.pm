package DB;

use warnings;
use strict;

use Exporter();

use DBI;
use Cfg;

BEGIN {
    our @ISA    = qw( Exporter );
    our @EXPORT = qw( $db );

    our $db = DBI->connect(
        'DBI:mysql:database=' . $cfg->{DB}->{n} . ';hostname=' . $cfg->{DB}->{h},
        $cfg->{DB}->{u},
        $cfg->{DB}->{p}
    ) or die("Cant connect to DB");
}

=pod

=encoding UTF-8

=head1 NAME

DB

=head1 VERSION

0.1

=head1 DESCRIPTION

DB - global access to DBI connection $db

=head1 SYNOPSIS

use DB;

print Dumper( $db->do("SHOW DATABASES") );

=head1 COPYRIGHT AND LICENSE

This is free software; you can redistribute it and/or modify
it under the same terms as the Perl 5 programming language system itself.

=head1 HISTORY

Version 0.1: first release; Aug 2017

=cut

1;
