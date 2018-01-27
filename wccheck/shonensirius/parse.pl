#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'http://shonen-sirius.com/';
$param{re_pre} = qr|<div class="contents">(.*?)</section>|s;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)">
	.*?
	<p[ ]class="title">(?'title'.*?)</p>
	\s*
	<p[ ]class="author">(?'author'.*?)</p>
}sx;

WCCheck::parse(%param);
