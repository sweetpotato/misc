#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'https://cycomi.com/';
$param{re_pre} = qr|<div id="daily">(.*?)<span class="left">読切</span>|s;
$param{re_loop} = qr{
	<a[ ]href="(?'link'/title[^\x{22}]*)"[^>]*>
	.*?
	<p[ ]class="title_name">(?'title'.*?)</p>
}sx;

WCCheck::parse(%param);
