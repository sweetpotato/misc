#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'http://www.ganganonline.com/';
$param{re_pre} = qr|<ul id="comicList">(.*?)</ul>|s;
$param{re_loop} = qr{
	<a[ ][^>]*[ ]href="(?'link'[^\x{22}]*)">
	.*?
	<span[ ]class="gn_cList_title"[^>]*>(?'title'.*?)</span>
	.*?
	<span[ ]class="gn_cList_author">(?'author'.*?)</span>
}sx;

WCCheck::parse(%param);
