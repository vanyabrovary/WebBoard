package Tpl;

use warnings;
use strict;

use Exporter();

use Template;
use Lib;
use Cfg;

BEGIN {
    our @ISA    = qw( Exporter );
    our @EXPORT = qw( get_tpl );
}

sub get_tpl(%);

sub get_tpl(%) {
    my $tpl = shift;
    my $req = shift;
    my %arg = @_;

    my $html = '';

    $arg{lib} = Lib->new($req);
    $arg{cfg} = $cfg->{PUBLIC};

    my $tt = Template->new( { INCLUDE_PATH => $ENV{'DOCUMENT_ROOT'} . '/html/tpl/' } )
      or die "TT instance error!";

    $tt->process( $tpl . '.html', \%arg, \$html ) or do {
        die $tt->error();
        return 0;
    };

    return $html;
}

=pod

=encoding UTF-8

=head1 NAME

Tpl

=head1 VERSION

0.1

=head1 DESCRIPTION

Tpl - simple TT implementation

=head1 SYNOPSIS

use Tpl;

print get_tpl('board_item');

=head1 COPYRIGHT AND LICENSE

This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.

=head1 HISTORY

Version 0.1: first release; Aug 2017

=cut

1;
