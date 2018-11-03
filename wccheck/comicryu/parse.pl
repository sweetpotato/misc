#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'https://comic-ryu.jp/lineup/';
$param{re_pre} = qr|<h3 class="rensai">(.*?)<h3 class="kanketsu">|s;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)"><img\s+[^>]*></a>
	\s*
	<p[ ]class="title">(?'title'.*?)</p>
}sx;

WCCheck::parse(%param);
