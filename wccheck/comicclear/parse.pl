#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'https://www.comic-clear.jp/';
$param{re_loop} = qr{
	<li><a[ ]href="(?'link'[^\x{22}]*)"[ ]title="(?'title'[^\x{22}]*)">
}sx;

WCCheck::parse(%param);
