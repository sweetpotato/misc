#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'http://www.comicgum.com/';
$param{re_pre} = qr|<h2>ALL CONTENTS</h2>(.*?)<h2>連載終了作品</h2>|s;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)">
	.*?
	<h3>(?'title'.*?)</h3>
	\s*
	<span[ ]class="list_author">(?'author'.*?)</span>
}sx;

WCCheck::parse(%param);
