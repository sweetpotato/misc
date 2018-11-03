#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'https://nikkangecchan.jp/';
$param{re_loop} = qr{
	<div[ ]class="imgBox">
	<a[ ]href="(?'link'[^\x{22}]*)">
	<img[ ][^>]*></a></div><div[ ]class="detailBox">
	<h3>(?'title'.*?)</h3>
}sx;

WCCheck::parse(%param);
