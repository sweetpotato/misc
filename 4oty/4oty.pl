#!/usr/bin/perl
use strict;
use warnings;
use utf8;
local $/ = undef;
binmode STDOUT, ":utf8";

my $REGEX_USERLINK = qr!http://4oty\.net/2016/user/[_0-9a-zA-Z]+!;

my $REGEX_NEWBOOKS  = qr{
	<div[ ]class="span12">
	(.*?)
	<div[ ]class="panel[ ]panel-success">
}sx;

my $REGEX_CONTBOOKS = qr{
	<div[ ]class="panel[ ]panel-success">
	(.*?)
	<div[ ]class="panel[ ]panel-info">
}sx;

my $REGEX_NEIGHBORS = qr{
	<div[ ]class="panel[ ]panel-info">
	.*?
	<div[ ]class="panel[ ]panel-info">
	(.*?)
	<div[ ]class="panel[ ]panel-default"[ ]
	style="max-width:[ ]400px;[ ]margin:[ ]0[ ]auto[ ]10px;">
}sx;

my $REGEX_BOOK = qr{
	<div[ ]class="col-xs-12[ ]col-md-4">
	(.*?)
	</table>
}sx;

my $REGEX_BOOK_TITLE_ID = qr{
	<div[ ]class="panel-heading">
	(.*?)
	</div>
	.*?
	<a[ ]href=\x{22}(.*?)/?\?
}sx;

my $REGEX_NEIGHBOR_LINK_SCREEN = qr{
	<a[ ]href="(.*?)"[ ]title="(.*?)">
}sx;

sub abspath_to_link { "http://4oty.net${_[0]}" }

sub trim { local $_ = $_[0]; s/\A\s+|\s+\z//g; $_ }

sub get_user_page {
	my ($user) = @_;
	if($user !~ /\A${REGEX_USERLINK}\z/) {
		return;
	}
	open my $in, '-|', 'curl', $user or die $!;
	binmode $in, ':utf8';
	local $_ = <$in>;
	close $in;
	return $_;
}

sub get_stdin {
	binmode STDIN, ':utf8';
	local $_ = <STDIN>;
	return $_;
}

### main ###
for my $user (@ARGV) {
	local $_ = ($user eq '-') ? &get_stdin() : &get_user_page($user);

	### 新刊 ###
	if(/${REGEX_NEWBOOKS}/) {
		local $_ = $1;
		while(/${REGEX_BOOK}/g) {
			local $_ = $1;
			if(/${REGEX_BOOK_TITLE_ID}/) {
				my ($title, $id) = (&trim($1), $2);
				print "newbook_\t${user}\t${id}\t${title}\n";
			}
		}
	}

	### 既刊 ###
	if(/${REGEX_CONTBOOKS}/) {
		local $_ = $1;
		while(/${REGEX_BOOK}/g) {
			local $_ = $1;
			if(/${REGEX_BOOK_TITLE_ID}/) {
				my ($title, $id) = (&trim($1), $2);
				print "contbook\t${user}\t${id}\t${title}\n";
			}
		}
	}

	### 似た人 ###
	if(/${REGEX_NEIGHBORS}/) {
		local $_ = $1;
		while(/${REGEX_NEIGHBOR_LINK_SCREEN}/g) {
			my ($link, $screen) = (&abspath_to_link($1), $2);
			print "neighbor\t${user}\t${link}\t${screen}\n";
		}
	}
}

__END__
