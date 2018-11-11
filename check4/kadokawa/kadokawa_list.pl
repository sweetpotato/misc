#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Check4;

sub on_error {
	my $content = shift;

	my $re_notice = qr{
		(
			<div\s+class="page-sub-title-wrap">
			\s*
			<h2\s+class="page-sub-title">.*?</h2>
			\s*
			</div>
			\s*
			<p\s+class="search-result-count">.*?</p>
			\s*
			<p\s+class="result-text">.*?</p>
		)
	}sx;
	$content =~ /$re_notice/ or die;

	my $notice = Check4::scrub($1);
	warn $notice;

	exit 0;
}

my %param = ();
$param{base} = 'https://www.kadokawa.co.jp/product/search/';
$param{on_error} = \&on_error;
$param{re_pre} = qr{
	<div\s+class="search-result-lists\s+--islist">
	(.*?)
	<div\s+class="re-search-form-box\s+isclose">
}sx;
$param{re} = qr{
	<div\s+class="book-face">
	\s*
	<a\s+href="([^\x22]*)">
}sx;

Check4::parse_list(%param);
