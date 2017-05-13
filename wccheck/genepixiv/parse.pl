#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{re_loop} = qr{
	<p[ ]class="title">
	<a[ ]href="(?'link'[^\x{22}]*)"[ ]title="[^\x{22}]*"[^>]*>
	(?'title'.*?)
	</a>
	</p>
	\s*
	<p[ ]class="author">(?'author'.*?)</p>
}sx;

WCCheck::parse(%param);
