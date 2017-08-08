package reCAPTCHA;

use warnings;
use strict;

use Exporter();

use Cfg;
use Captcha::reCAPTCHA;

BEGIN {
    our ( @ISA, @EXPORT_OK );
    @ISA       = qw(Exporter);
    @EXPORT_OK = qw( GetCaptchaHtml GetCaptchaResult CheckCaptcha );
}

sub GetCaptchaHtml {
    my $captcha = Captcha::reCAPTCHA->new;
    my $html = $captcha->get_html( $cfg->{reCAPTCHA}->{public}, '', '', { theme => "white", lang => "ru" } );
    return $html;
}

sub GetCaptchaResult {
    my $args    = shift;
    my $captcha = Captcha::reCAPTCHA->new;

    my $result = $captcha->check_answer(
        $cfg->{reCAPTCHA}->{private},          $cfg->{reCAPTCHA}->{extip},
        $args->{my_recaptcha_challenge_field}, $args->{my_recaptcha_response_field},
    );
    return $result;
}

sub CheckCaptcha {
    my $args   = shift;
    my $result = GetCaptchaResult($args);
    return $result->{is_valid};
}

=pod

=encoding UTF-8

=head1 NAME

reCAPTCHA

=head1 VERSION

0.1

=head1 DESCRIPTION

reCAPTCHA - global access to reCAPTCHA subroutines

=head1 SYNOPSIS

use reCAPTCHA qw/CheckCaptcha/;

unless ( CheckCaptcha( $self->{arg} ) ) {

    print "bad captcha";

}

=head1 COPYRIGHT AND LICENSE

This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.

=head1 HISTORY

Version 0.1: first release; Aug 2017

=cut

1;
