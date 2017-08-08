package WebBoard;

use warnings;
use strict;

use Mojo::Base 'Mojolicious';

sub startup {
    my $self = shift;
    my $r    = $self->routes;
    $self->plugin('RemoteAddr');
    $r->get('/')->to( controller => 'BoardItem', action => 'index' );
    $r->get('/board_item/list')->to( controller => 'RestBoardItem', action => 'board_item_list' );
    $r->any('/board_item/save')->to( controller => 'RestBoardItem', action => 'board_item_save' );
}

=pod

=encoding UTF-8

=head1 NAME

WebBoard

=head1 VERSION

0.1

=head1 DESCRIPTION

WebBoard - startap for Mojolicious routes

=head1 COPYRIGHT AND LICENSE

This is free software; you can redistribute it and/or modify
it under the same terms as the Perl 5 programming language system itself.

=head1 HISTORY

Version 0.1: first release; Aug 2017

=cut

1;
