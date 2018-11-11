#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'https://web-ace.jp/youngaceup/contents/';
$param{re_loop} = qr{
	<li[ ]class="box[ ]inner[ ]col[ ]col-width-50">
	\s*
	<h2>(?'title'.*?)</h2>
	.*?
	<a[ ]href="(?'link'[^\x{22}]*)">
}sx;

WCCheck::parse(%param);
