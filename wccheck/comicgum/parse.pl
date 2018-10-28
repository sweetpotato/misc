#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'http://www.comicgum.com/';
$param{re_pre} = qr|<li[^>]*>連載中作品<img[^>]*>(.*?)</section>|s;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)">
	<img[ ][^>]*[ ]alt="(?'title'[^\x{22}]*)">
}sx;

WCCheck::parse(%param);
