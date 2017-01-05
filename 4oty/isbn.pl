#!/usr/bin/perl
use strict;
use warnings;

sub print_record {
	my($isbn,$n) = @_;
	my $pub = substr($isbn, 0, $n);
	my $sub = "-";
	print "${pub}\t${sub}\t${isbn}\n";
}

sub print_subrecord {
	my($isbn,$n,$m) = @_;
	my $pub = substr($isbn, 0, $n);
	my $sub = $m ? substr($isbn, 0, $m) : "others";
	print "${pub}\t${sub}\t${isbn}\n";
}

while(<STDIN>) {
	chomp;

	# see http://www.isbn-center.jp/guide/08.pdf (p.33)
	if(/^4[01]/) {
		if(/^404/){ # KADOKAWA
			if(/^40406/) { # Media Factory
				print_subrecord($_, 3, 5);
			} else { # others
				print_subrecord($_, 3);
			}
		} else {
			print_record($_, 3);
		}
	} elsif(/^4[2-6]/) {
		print_record($_, 4);
	} elsif(/^4(?:7|8[0-4])/){
		if(/^48322/){ # Houbunsha
			if(/^48322[45]/) { # Time or KR
				print_subrecord($_, 5, 6);
			} else { # others (maybe empty)
				warn $_;
			}
		} else {
			print_record($_, 5);
		}
	} elsif(/^48[5-9]/) {
		print_record($_, 6);
	} elsif(/^49[0-4]/) {
		print_record($_, 7);
	} elsif(/^49[5-9]/) {
		print_record($_, 8);
	} else {
		warn $_;
	}
}

__END__
