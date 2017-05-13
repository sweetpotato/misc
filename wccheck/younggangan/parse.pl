#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'http://www.square-enix.co.jp/magazine/yg/introduction/';
$param{re_loop} = qr{
	<div[ ]class="introduction_right">
	\s*
	(?:
		<div[ ]class="mediamix_box">
		\s*
		<div[ ]class="info">.*?</div>
		\s*
		<div[ ]class="title">(?'title'.*?)</div>
		\s*
		</div>
	|
		<p>(?'title'.*?)</p>
	)
	\s*
	<div[ ]class="introduction_button(?:_longtitle)?">
	\s*
    <div[ ]class="left_button">
    \s*
    <a[ ]href="(?'link'[^\x{22}]*)">
}sx;

WCCheck::parse(%param);
