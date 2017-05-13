#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'http://comic-earthstar.jp/';
$param{re_loop} = qr{
	<li[ ]class="img"><a[ ]href="(?'link'[^\x{22}]*)"[ ]class="img_link">
	.*?
	<div[ ]class="title_date">(?'m'\d+)月(?'d'\d+)日
}sx;

WCCheck::parse(%param);
