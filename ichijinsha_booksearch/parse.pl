#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use URI;
my $base = 'http://data.ichijinsha.co.jp/book/booksearch/booksearch_list.php';

sub trim {
	local $_ = $_[0];
	s/<[^>]*>//g;
	s/\s+/ /g;
	s/^\s+//;
	s/\s+$//;
	s/&quot;/\x{22}/g;
	s/&lt;/</g;
	s/&gt;/>/g;
	s/&amp;/&/g;
	return $_;
}

my $re = qr{
	<div[ ]class="book">
	.*?
	<h2><a[ ]href="(?'link'booksearch_detail\.php\?i=\d+)[^\x{22}]*">
	(?'title'.*?)
	</a></h2>
	\s+
	<span[ ]class="f10">
	(?'author'.*?)
	</span>
	\s+
	<p>.*?</p>
	\s+
	<p>(?'date'.*?)</p>
}sx;

my $code = 1;

local $/ = undef;
local $_ = <STDIN>;
while(/$re/g) {
	my @a = ();
	push @a, URI->new(trim($+{link}))->abs($base);
	push @a, trim($+{date});
	push @a, trim($+{title});
	push @a, trim($+{author});
	print join "\t", @a;
	print "\r\n";
	$code = 0;
}

exit $code;

__END__
