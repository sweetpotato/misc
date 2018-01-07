#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'http://over-lap.co.jp/gardo/';
$param{re_loop} = qr{
	<div[ ]class="d_area">
	\s*
	<h3>(.*?)</h3>
	\s*
	<h2><a[ ]href="(?'link'[^\x{22}]*)">(?'title'.*?)</a></h2>
}sx;

WCCheck::parse(%param);
