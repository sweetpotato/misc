#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'http://chancro.jp/';
$param{re_loop} = qr{
	<li[ ]class="clearfix">
	\s*
	<a[ ]href="(?'link'[^\x{22}]*)">
	\s*
	<figure>
	\s*
	<img[ ][^>]*>
	\s*
	<figcaption>
	<strong>(?'author'.*?)</strong>(?'title'.*?)
	</figcaption>
}sx;

WCCheck::parse(%param);