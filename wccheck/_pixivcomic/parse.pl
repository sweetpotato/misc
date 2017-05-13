#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'https://comic.pixiv.net/';
$param{re_loop} = qr{
	<hgroup>
	\s*
	<h1><a[ ]href="(?'link'[^\x{22}]*)">
	(?'title'.*?)
	</a></h1>
	\s*
	<h2[ ]class="author">(?'author'.*?)</h2>
}sx;

WCCheck::parse(%param);
