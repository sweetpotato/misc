#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Check4;

sub on_error {
	my ($url, $content) = @_;

	# U+FF5C: FULLWIDTH VERTICAL LINE
	$content =~ m!<li\s+class="bgClr02">電子のみ</li>! or die;
	$content =~ m!<title>([^\x{FF5C}]+)! or die;

	my $title = $1;
	warn qq{$url\t$title is ebook only};

	exit 0;
}

my %param = ();
$param{url} = shift;
$param{on_error} = \&on_error;
$param{re} = qr{
	<h2>製品情報</h2>
	.*?
	<table>
	.*?
	<th>製品名</th>\s*<td>(?'title'.*?)</td>
	.*?
	<th>発売日</th>\s*<td>(?'y'\d+)年(?'m'\d+)月(?'d'\d+)日</td>
	.*?
	<th>ISBN</th>\s*<td>(?'isbn13'.*?)</td>
}sx;

Check4::parse_item(%param);
