package CRUD::BoardItem;

use warnings;
use strict;

use CRUD;
our @ISA = qw/CRUD/;

sub db_table()   { 'board_item' }
sub db_columns() { qw/id user_name user_email user_ip user_agent user_url user_country item_content item_created/ }

sub db_order() { 'item_created DESC' }

=pod

=encoding UTF-8

=head1 NAME

CRUD::BoardItem

=head1 VERSION

0.1

=head1 DESCRIPTION

CRUD::BoardItem - board_item MySQL table description

=head1 SYNOPSIS

use CRUD::BoardItem;

print CRUD::BoardItem->list_json();

=head1 COPYRIGHT AND LICENSE

This is free software; you can redistribute it and/or modify
it under the same terms as the Perl 5 programming language system itself.

=head1 HISTORY

Version 0.1: first release; Aug 2017

=cut

1;
