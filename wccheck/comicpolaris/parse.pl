#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{re_pre} = qr|<div class="main">(.*?)<div class="update_link_more">|s;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)">
	\s*
	<img[ ][^>]*[ ]alt="(?'title'[^\x{22}]*)">
}sx;

WCCheck::parse(%param);
