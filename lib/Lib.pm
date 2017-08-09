package Lib;

use warnings;
use strict;

use Geo::IP;
use Cfg;
use reCAPTCHA qw/ GetCaptchaHtml /;

sub new { bless( {}, shift ) }

sub get_captcha_html {
    return GetCaptchaHtml();
}

sub user_country {
    my $gi = Geo::IP->open( $cfg->{GEOIP}->{path} ) or return '';
    return $gi->country_code_by_addr( $ENV{REMOTE_ADDR} );
}

sub user_ip {
    return $ENV{REMOTE_ADDR};
}

sub user_agent {
    return $ENV{HTTP_USER_AGENT};
}

=pod

=encoding UTF-8

=head1 NAME

Lib

=head1 VERSION

0.1

=head1 DESCRIPTION

Lib - access to some subroutines from TT

=head1 SYNOPSIS

[% lib.get_captcha_html %]
[% lib.user_country %]
[% lib.user_ip %]
[% lib.user_agent %]

=head1 COPYRIGHT AND LICENSE

This is free software; you can redistribute it and/or modify
it under the same terms as the Perl 5 programming language system itself.

=head1 HISTORY

Version 0.1: first release; Aug 2017

=cut

1;
