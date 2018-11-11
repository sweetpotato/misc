#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Check4;

sub on_finish {
	my ($url, $content) = @_;

	if ($content =~ m!<div\s+class="next_list">(.*?)</div>!s) {
		my $notice = Check4::scrub($1);
		print "#N/A\t#N/A\t#N/A\t$notice\n";
	}
}

my %param = ();
$param{url} = shift;
$param{on_finish} = \&on_finish;
$param{re} = qr{
	<div\s+class="title">
	\s*
	<h1>(?'title'.*?)</h1>
	.*?
	<table\s+class="volume">
	.*?
	<th>発売日</th>\s*<td>(?'date'.*?)</td>
	.*?
	<th>ISBN</th>\s*<td>(?'isbn13'.*?)</td>
}sx;

Check4::parse_item(%param);
