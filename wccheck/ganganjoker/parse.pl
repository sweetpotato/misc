#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{mode} = ':encoding(cp932)';
$param{base} = 'http://www.jp.square-enix.com/magazine/joker/series/';
$param{re_pre} = qr|<div class="series_box">(.*?)</div>|s;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)">
	<img[ ][^>]*[ ]alt="(?'title'[^\x{22}]*)"[ ][ ]/>
}sx;

WCCheck::parse(%param);
