#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'http://tap.akitashoten.co.jp/';
$param{re_loop} = qr{
	<li[ ]class="(?:completed[ ])?clearfix">
	\s*
	<a[ ]href="(?'link'[^\x{22}]*)">
	\s*
	<figure>
	\s*
	<img[ ][^>]*>
	\s*
	<figcaption>
	\s*
	<strong>(?'author'.*?)</strong>(?'title'.*?)
	</figcaption>
}sx;

WCCheck::parse(%param);
