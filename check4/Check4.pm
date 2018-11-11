#!/usr/bin/env perl
package Check4;
use strict;
use warnings;
use URI;
use base qw( Exporter );

sub scrub {
	my $content = shift;
	$content =~ s/<[^\x3E]*>//g;
	$content =~ s/[ \t\r\n]+/ /g;
	$content =~ s/\A\s+|\s+\z//g;
	return $content;
}

sub validate_isbn13 {
	my $isbn13 = shift;

	if ($isbn13 !~ /\A\d{13}\z/) { return; } # invalid

	my @a = split //, $isbn13;
	my $sum = 0;
	$sum += $a[ 0] * 1;
	$sum += $a[ 1] * 3;
	$sum += $a[ 2] * 1;
	$sum += $a[ 3] * 3;
	$sum += $a[ 4] * 1;
	$sum += $a[ 5] * 3;
	$sum += $a[ 6] * 1;
	$sum += $a[ 7] * 3;
	$sum += $a[ 8] * 1;
	$sum += $a[ 9] * 3;
	$sum += $a[10] * 1;
	$sum += $a[11] * 3;
	$sum += $a[12] * 1;

	if ($sum % 10 != 0) { return; } # invalid

	return 1; # valid
}

sub make_isbn10 {
	my $isbn13 = shift;
	&validate_isbn13($isbn13) or die;

	my $isbn9 = substr($isbn13, 3, 9);
	my @a = split //, $isbn9;
	my $sum = 0;
	$sum += $a[0] * 10;
	$sum += $a[1] *  9;
	$sum += $a[2] *  8;
	$sum += $a[3] *  7;
	$sum += $a[4] *  6;
	$sum += $a[5] *  5;
	$sum += $a[6] *  4;
	$sum += $a[7] *  3;
	$sum += $a[8] *  2;
	$sum = (11 - ($sum % 11)) % 11;
	$sum = ($sum == 10) ? "X" : "$sum";

	return "$isbn9$sum";
}

sub parse_list {
	my %param = @_;

	binmode STDIN,  ':utf8';
	binmode STDOUT, ':utf8';
	binmode STDERR, ':utf8';
	local $/ = undef;

	my $content = <STDIN>;
	$content =~ s/<!--.*?-->//gs;
	$content =~ s/[ \t\r\n]+/ /gs;

	if (defined($param{re_pre})) {
		if ($content !~ /$param{re_pre}/) {
			defined($param{on_error}) or die;
			$param{on_error}->($content);
			die;
		}
		$content = $1;
	}

	while ($content =~ /$param{re}/g) {
		my $link = URI->new_abs($1, $param{base})->as_string;
		print "$link\n";
	}
}

sub parse_item {
	my %param = @_;
	my $url = $param{url};

	binmode STDIN,  ':utf8';
	binmode STDOUT, ':utf8';
	binmode STDERR, ':utf8';
	local $/ = undef;

	my $content = <STDIN>;
	$content =~ s/<!--.*?-->//gs;
	$content =~ s/[ \t\r\n]+/ /g;

	if ($content !~ /$param{re}/) {
		defined($param{on_error}) or die;
		$param{on_error}->($url, $content);
		die;
	}

	my $title = &scrub($+{title});

	my $date;
	if (defined($+{date})) {
		$date = $+{date};
	} else {
		my $y = $+{y};
		my $m = $+{m};
		my $d = $+{d};
		$date = "$y/$m/$d";
	}

	my $isbn10;
	if (defined($+{isbn10})) {
		$isbn10 = $+{isbn10};
		$isbn10 =~ s/-//g;
	} else {
		my $isbn13 = $+{isbn13};
		$isbn13 =~ s/-//g;
		$isbn10 = &make_isbn10($isbn13);
	}

	print "$url\t$isbn10\t$date\t$title\n";

	if (defined($param{on_finish})) {
		$param{on_finish}->($url, $content);
	}
}

1;
