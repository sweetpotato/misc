#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{re_loop} = qr{
	<section[ ][^>]*[ ]class="view-list[ ]ng-scope">
	\s*
	<a[ ][^>]*[ ]href="(?'link'[^\x{22}]*)">
	\s*
	<h3[ ][^>]*>(?'title'.*?)</h3>
	.*?
	<span[ ][^>]*>(?'author'.*?)</span>
	.*?
	<time[ ][^>]*>(?'date'\d+/\d+/\d+)
}sx;

WCCheck::parse(%param);
