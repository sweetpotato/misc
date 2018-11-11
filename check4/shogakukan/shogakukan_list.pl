#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Check4;

my %param = ();
$param{base} = 'https://comics.shogakukan.co.jp/';
$param{re_pre} = qr{<section\s+id="sec2">(.*?)</section>}s;
$param{re} = qr{<li>\s*<a\s+href="([^\x22]*)">}s;

Check4::parse_list(%param);
