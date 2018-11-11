#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Check4;

my %param = ();
$param{base} = 'http://kc.kodansha.co.jp/';
$param{re} = qr{
	<ul\s+class="btn">
	\s*
	<li\s+class="icoArwR"><a\s+href="([^\x22]*)"[^\x3E]*>
}sx;

Check4::parse_list(%param);
