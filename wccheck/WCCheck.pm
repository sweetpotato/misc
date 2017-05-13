#!/usr/bin/perl
package WCCheck;
use strict;
use warnings;
use URI;

use base qw( Exporter );

sub read_stdin {
	my %opt = @_;

	my $mode = $opt{mode} || ':utf8';
	my $re_pre = $opt{re_pre} || undef;

	binmode STDIN, $mode;
	local $/ = undef;

	my $content = <STDIN>;
	$content =~ s|<!--.*?-->||gs;

	if(defined($re_pre)) {
		if($content =~ /$re_pre/) {
			$content = $1;
		} else {
			return; # failure
		}
	}

	return $content;
}

sub print_record {
	print join "\t", @_;
	print "\r\n";
}

sub guess_year {
	my($m, $d) = @_;

	my @today = localtime(time);
	my $y_today = $today[5]+1900;
	my $m_today = $today[4]+1;
	my $d_today = $today[3];

	my $y = ($m > $m_today || ($m == $m_today && $d > $d_today))
		? $y_today-1 : $y_today;

	return "$y/$m/$d";
}

sub trim {
	local $_ = $_[0];
	s/<[^>]*>/ /g;
	s/\s+/ /gs;
	s/^\s+|\s+$//gs;
	return $_;
}

sub parse {
	my %param = @_;

	my $content = read_stdin(
		mode => $param{mode},
		re_pre => $param{re_pre}) or die;

	while($content =~ /$param{re_loop}/g) {
		my @a = ();
		if(defined($+{link})) {
			my $link = defined($param{base})
				? URI->new($+{link})->abs($param{base})
				: $+{link};
			push(@a, $link);
		}
		if(defined($+{title})) {
			push(@a, trim($+{title}));
		}
		if(defined($+{author})) {
			push(@a, trim($+{author}));
		}
		if(defined($+{date})) {
			push(@a, trim($+{date}));
		}
		if(defined($+{m}) && defined($+{d})) {
			my $date = defined($+{y})
				? "$+{y}/$+{m}/$+{d}"
				: guess_year($+{m}, $+{d});
			push(@a, $date);
		}
		if(!scalar(@a)) {
			next;
		}

		print_record(@a);
	}
}

1;
