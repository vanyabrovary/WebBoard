package Valid;

use warnings;
use strict;

sub form {
    my $self = shift;
    my $name = shift;
    my $arg  = shift;

    my $location   = "Valid/$name.pm";
    my $this_class = "Valid::$name";

    require $location;

    my $form = $this_class->new( arg => $arg );
    my $wrong = $form->valid;
    if ( scalar @$wrong ) {
        my $err;
        $err .= uc($_) . ', ' foreach @$wrong;
        $err =~ s/, $//;
        return $err;
    }
    else {
        return 0;
    }
}

=pod

=encoding UTF-8

=head1 NAME

Valid

=head1 VERSION

0.1

=head1 DESCRIPTION

Valid - factory for Valid/ folder

=head1 SYNOPSIS

my $invalid = Valid->form( 'BoardItem', $arg );

unless ($invalid) {

    print "args valid";

} else {

    print "args invalid";

}

=head1 COPYRIGHT AND LICENSE

This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.

=head1 HISTORY

Version 0.1: first release; Aug 2017

=cut

1;
