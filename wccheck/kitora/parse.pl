#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{re_loop} = qr{
	<p[ ]class="date">(?'date'\d+/\d+/\d+)</p>
	\s*
	<div[ ]class="cover">
	\s*
	<a[ ]href="(?'link'[^\x{22}]*)">
	\s*
	(?:
		<img[ ]class="icon"\s+[^>]*>
		\s*
	)?
	<img[ ]src=[^>]*[ ]alt="(?'title'[^\x{22}]*)"[ ][^>]*>
}sx;

WCCheck::parse(%param);
