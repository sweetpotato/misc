#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{re_pre} = qr|<h3[^>]*>連載中の作品</h3>(.*?)<h3[^>]*>読み切り作品</h3>|s;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)"[^>]*>
	\s*
	<img[ ][^>]*[ ]alt="(?'title'[^\x{22}]*)"[ ]/>
	.*?
	<span[ ]class="inner">(?'m'\d+)月(?'d'\d+)日
}sx;

WCCheck::parse(%param);
