#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{re_pre} = qr|<div[ ]class="serialWorks__inner">(.*?)<div[ ]class="aserialWorks__bottom">|s;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)">
	.*?
	<span[ ]class="title">(?'title'.*?)</span>
}sx;

WCCheck::parse(%param);
