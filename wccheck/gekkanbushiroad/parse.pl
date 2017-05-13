#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'http://gekkan-bushi.com/comics/';
$param{re_loop} = qr{
	<li><a\s+[^>]*><img\s+[^>]*></a>(?:<br\s*/?>)?
	\s*
	<a\s+href="(?'link'[^\x{22}]*)">(?'title'.*?)</a><br\s*/?>
	\s*
	(?'author'.*?)</li>
}sx;

WCCheck::parse(%param);
