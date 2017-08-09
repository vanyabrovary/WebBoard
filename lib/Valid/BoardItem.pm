package Valid::BoardItem;

use warnings;
use strict;

use Moose;
use Email::Valid;
use reCAPTCHA qw/CheckCaptcha/;

has 'arg', is => 'ro', required => 1;

sub valid() {
    my $self = shift;
    my @wrong;
    foreach (qw/user_name user_email item_content captcha/) {
        my $str = $self->{arg}->{$_};

        if ( 'user_name' eq $_ ) {

            unless ( $str =~ m/^\w+$/i ) {
                push @wrong, $_;
            }

        }

        if ( 'item_content' eq $_ ) {

            unless ( $str =~ m/^[a-z0-9_\-\.,;:\\\@\/#\$%\&\*\(\)\[\]'" ]{1,1024}$/i ) {
                push @wrong, $_;
            }

        }

        if ( 'user_email' eq $_ ) {

            my $e;
            eval { $e = Email::Valid->address( -address => $str, -mxcheck => 1 ); };
            unless ($e) { push @wrong, $_; }

        }
        if ( 'captcha' eq $_ ) {

            unless ( CheckCaptcha( $self->{arg} ) ) {
                push @wrong, $_;
            }

        }
    }
    return \@wrong;
}

=pod

=encoding UTF-8

=head1 NAME

Valid::BoardItem

=head1 VERSION

0.1

=head1 DESCRIPTION

Valid::BoardItem - form validation for board_item MySQL table

=head1 COPYRIGHT AND LICENSE

This is free software; you can redistribute it and/or modify
it under the same terms as the Perl 5 programming language system itself.

=head1 HISTORY

Version 0.1: first release; Aug 2017

=cut

1;

