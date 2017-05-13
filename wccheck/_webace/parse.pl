#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'https://web-ace.jp/';
$param{re_pre} = qr{
	<div[ ]class="container"[ ]id="series-comic-PC">
	(.*?)
	</section>
}sx;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)">
	.*?
	<h3>(?'title'.*?)</h3>
}sx;

WCCheck::parse(%param);
