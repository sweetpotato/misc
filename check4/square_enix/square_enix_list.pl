#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Check4;

sub on_error {
	my $content = shift;

	my $re_notice = qr{<h2\s+class="headTitle02\s+fo18">(.*?)</p>}s;
	$content =~ /$re_notice/ or die;

	my $notice = Check4::scrub($1);
	warn $notice;

	exit 0;
}

my %param = ();
$param{base} = 'https://magazine.jp.square-enix.com/top/comics/';
$param{on_error} = \&on_error;
$param{re_pre} = qr{<ul\s+class="listComics\s+clearfix">(.*?)</ul>}s;
$param{re} = qr{<p\s+class="img01">\s*<a\s+href="([^\x22]*)">};

Check4::parse_list(%param);
