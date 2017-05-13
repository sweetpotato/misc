#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'http://comic-walker.com/';
$param{re_pre} = qr|<dl class="tileListWrap">(.*?)</dl>|s;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)">
	\s*
	<h3><span>(?'title'.*?)</span></h3>
}sx;

WCCheck::parse(%param);
