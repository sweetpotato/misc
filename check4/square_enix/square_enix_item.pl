#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Check4;

my %param = ();
$param{url} = shift;
$param{re} = qr{
	<p\s+class="tit02\s+fo25">(?'title'.*?)</p>
	.*?
	<p\s+class="tit03">.*?発売日：(?'y'\d+)年(?'m'\d+)月(?'d'\d+)日</p>
	.*?
	<p\s+class="txt02">.*?ISBN：(?'isbn13'.*?)</p>
}sx;

Check4::parse_item(%param);
