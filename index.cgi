#!/usr/bin/perl

use FindBin qw($Bin);
use lib "$Bin/lib";

use Mojolicious::Commands;
Mojolicious::Commands->start_app('WebBoard');

## Mojolicious start_up script
