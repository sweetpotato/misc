#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{mode} = ':encoding(cp932)';
$param{base} = 'http://gangan.square-enix.co.jp/introduction/';
$param{re_pre} = qr{
	<img[ ][^>]*[ ]alt="連載作品"[ ]/>
	(.*?)
	<img[ ][^>]*[ ]alt="連載終了作品はこちら"[ ]/>
}sx;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)">
	<img[ ][^>]*[ ]alt="(?'title'[^\x{22}]*)"[ ]/>
}sx;

WCCheck::parse(%param);
