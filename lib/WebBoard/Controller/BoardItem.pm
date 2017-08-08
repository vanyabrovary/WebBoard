package WebBoard::Controller::BoardItem;

use warnings;
use strict;

use Mojo::Base 'Mojolicious::Controller';

use Tpl qw/get_tpl/;

sub index {
    my $self = shift;

    $self->render( 'data' => get_tpl('board_item') );
}

=pod

=encoding UTF-8

=head1 NAME

WebBoard::Controller::BoardItem

=head1 VERSION

0.1

=head1 DESCRIPTION

WebBoard::Controller::BoardItem - Mojolicious controller for /

=head1 COPYRIGHT AND LICENSE

This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.

=head1 HISTORY

Version 0.1: first release; Aug 2017

=cut

1;
