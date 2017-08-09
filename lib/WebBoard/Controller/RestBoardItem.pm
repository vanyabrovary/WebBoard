package WebBoard::Controller::RestBoardItem;

use warnings;
use strict;

use Mojo::Base 'Mojolicious::Controller';

use Tpl qw/get_tpl/;
use CRUD::BoardItem;
use Valid;
use Data::Dumper;
use JSON::Syck;


sub board_item_list {
    my $self = shift;

    $JSON::Syck::ImplicitUnicode = 1;

    $self->render( data => JSON::Syck::Dump( CRUD::BoardItem->list_json() )  );
}

sub board_item_save {
    my $self = shift;

    my $arg = $self->req->params->to_hash;
    my $invalid = Valid->form( 'BoardItem', $arg );
    unless ($invalid) {
        my $crud = CRUD::BoardItem->new($arg);
        $crud->save();
        $self->render( text => 'OK' );
    }
    else {
        $self->render( text => $invalid );
    }
}

=pod

=encoding UTF-8

=head1 NAME

WebBoard::Controller::RestBoardItem

=head1 VERSION

0.1

=head1 DESCRIPTION

WebBoard::Controller::RestBoardItem - Mojolicious controller for board_item/save,  board_item/list

=head1 COPYRIGHT AND LICENSE

This is free software; you can redistribute it and/or modify
it under the same terms as the Perl 5 programming language system itself.

=head1 HISTORY

Version 0.1: first release; Aug 2017

=cut

1;
