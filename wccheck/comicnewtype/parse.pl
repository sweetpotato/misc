#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'https://comic.webnewtype.com/contents/';
$param{re_loop} = qr{
	<li[ ]class="OblongCard--border">
	\s*
	<a[ ]href="(?'link'[^\x{22}]*)">
	.*?
	<h3[ ]class="OblongCard-title">(?'title'.*?)</h3>
	\s*
	<div[ ]class="OblongCard-info">(?'author'.*?)</div>
}sx;

WCCheck::parse(%param);
