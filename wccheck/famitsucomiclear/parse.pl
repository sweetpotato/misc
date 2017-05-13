#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{mode} = ':encoding(cp932)';
$param{base} = 'https://www.famitsu.com/comic_clear/';
$param{re_loop} = qr{
	<div><a[ ]href="(?'link'[^\x{22}]*)">
	<img[ ]src="[^\x{22}]*"[ ]alt="(?'title'[^\x{22}]*)"/>
	</a></div>
}sx;

WCCheck::parse(%param);
