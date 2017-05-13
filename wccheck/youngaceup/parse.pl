#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'https://web-ace.jp/youngaceup/contents/';
$param{re_loop} = qr{
	<div[ ]class="box[ ]inner[ ]col[ ]col-width-50">
	\s*
	<h3>(?'title'.*?)</h3>
	.*?
	<a[ ]href="(?'link'[^\x{22}]*)">
}sx;

WCCheck::parse(%param);
