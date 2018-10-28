#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'https://cycomi.com/fw/cycomibrowser/title/serialization/';
$param{re_loop} = qr{
	<a[ ]href="(?'link'/fw/[^\x{22}]*)"[^>]*>
	\s*
	<div[ ]class="card-image">
	.*?
	<p[ ]class="card-texts-title">(?'title'.*?)</p>
}sx;

WCCheck::parse(%param);
