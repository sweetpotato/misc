#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use URI;
use WCCheck;

my %param = ();
$param{base} = 'http://online.ichijinsha.co.jp/';
$param{re_pre} = qr|<div id="centerpane">(.*?)</div>|s;
$param{re_loop} = qr|<h3><a href="(?'link'[^\x{22}]*)">(?'title'.*?)</a></h3>|s;

WCCheck::parse(%param);
