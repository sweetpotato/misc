#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{mode} = ':encoding(cp932)';
$param{base} = 'http://www.jp.square-enix.com/magazine/biggangan/introduction/';
$param{re_pre} = qr|<span>連載作品</span>(.*?)<span>連載終了作品</span>|s;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)">
	<img[ ][^>]*[ ]alt="(?'title'[^\x{22}]*)"[^>]*>
}sx;

WCCheck::parse(%param);
