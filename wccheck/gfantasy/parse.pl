#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{mode} = ':encoding(cp932)';
$param{base} = 'http://www.square-enix.co.jp/magazine/gfantasy/';
$param{re_pre} = qr|<div id="gf_serialBox">(.*?)</ul>|s;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)">
	.*?
	<img[ ][^>]*[ ]alt="(?'title'[^\x{22}]*)"[ ]/>
}sx;

WCCheck::parse(%param);
