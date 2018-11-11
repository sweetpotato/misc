#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Check4;

sub on_error {
	my ($url, $content) = @_;

	my $re_title = qr{<title>([^\x7C]+)};
	$content =~ /$re_title/ or die;

	my $title = Check4::scrub($1);
	warn qq{$url\t"$title" does not have ISBN};

	exit 0;
}

my %param = ();
$param{url} = shift or die;
$param{on_error} = \&on_error;
$param{re} = qr{
	<h1\s+id="book-title-sp"\s+class="book-title">(?'title'.*?)</h1>
	.*?
	<dd\s+class="detail-release-text">(?'y'\d+)年(?'m'\d+)月(?'d'\d+)日</dd>
	.*?
	<dd\s+class="detail-isbn-text">(?'isbn13'.*?)</dd>
}sx;

Check4::parse_item(%param);
