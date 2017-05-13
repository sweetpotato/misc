#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'http://bslogcomic.com/';
$param{re_pre} = qr{
	<div[ ]id="frame-contents">
	(.*?)
	<div[ ]id="right-column">
}sx;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)">
	<img[ ][^>]*[ ]alt="(?'title'[^\x{22}]*)">
}sx;

WCCheck::parse(%param);
