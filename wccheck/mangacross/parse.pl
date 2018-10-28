#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)">
	<img[ ][^>]*>
	<span[ ]class="banner-box__title">(?'title'.*?)</span>
}sx;

WCCheck::parse(%param);
