#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use URI;
use WCCheck;

my $base = 'http://online.ichijinsha.co.jp/';
my $re_pre = qr|<div id="centerpane">(.*?)</div>|s;
my $re_loop = qr|<ul>(.*?)</ul>|s;
my $re_subloop = qr|<h3><a href="([^\x{22}]*)">(.*?)</a></h3>|s;

my $content = WCCheck::read_stdin(re_pre => $re_pre) or die;
while($content =~ /$re_loop/g) {
	my $subcontent = $1;
	while($subcontent =~ /$re_subloop/g) {
		my($link, $title) = (URI->new($1)->abs($base), WCCheck::trim($2));
		WCCheck::print_record($link, $title);
	}
}
