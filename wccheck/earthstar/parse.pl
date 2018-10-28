#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'https://comic-earthstar.jp/';
$param{re_loop} = qr{
	<li[ ]class="img"><a[ ]href="(?'link'[^\x{22}]*)"[ ]class="img_link">
}sx;

WCCheck::parse(%param);
