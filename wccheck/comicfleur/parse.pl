#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use WCCheck;

my %param = ();
$param{base} = 'http://comic.mf-fleur.jp/';
$param{re_pre} = qr|<section id="top_lineup">(.*?)</section>|s;
$param{re_loop} = qr{
	<a[ ]href="(?'link'[^\x{22}]*)">
	\s*
	<img[ ][^>]*[ ]alt="(?'title'[^\x{22}]*)">
	\s*
	</a>
	\s*
	(?:
		<div[ ]class="bg_date[ ]new">
		<div[ ]class="date[ ]cf">
		<p[ ]class="txt">NEW!!</p>
	|
		<div[ ]class="bg_date[ ]old">
		<div[ ]class="date[ ]cf">
	)
	\s*
	<p[ ]class="update">(?'y'\d+)\.(?'m'\d+)\.(?'d'\d+)
}sx;

WCCheck::parse(%param);
