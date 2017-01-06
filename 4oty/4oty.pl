#!/usr/bin/perl
use strict;
use warnings;
use utf8;
local $/ = undef;
binmode STDIN, ':utf8';
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

my $REGEX_BOOK_TITLE_ID_DESC = qr{
	<div[ ]class="panel-heading">
	(.*?)
	</div>
	.*?
	<a[ ]href=\x{22}(.*?)/?\?
	.*?
	<td[ ]colspan="2">
	(.*?)
	</td>
}sx;

my $REGEX_NEIGHBOR_LINK_SCREEN = qr{
	<a[ ]href="(.*?)"[ ]title="(.*?)">
}sx;

sub abspath_to_link { "http://4oty.net${_[0]}" }

sub trim { local $_ = $_[0]; s/\A\s+|\s+\z//g; $_ }

sub walk_books {
	my ($newcont, $regex_books, $user) = @_;

	if(/${regex_books}/) {
		local $_ = $1;
		while(/${REGEX_BOOK}/g) {
			local $_ = $1;
			if(/${REGEX_BOOK_TITLE_ID_DESC}/) {
				my ($title, $id, $desc) = (&trim($1), $2, &trim($3));
				$desc =~ s/[\t\r\n]+/ /g;
				print "${newcont}\t${user}\t${id}\t${title}\t${desc}\n";
			}
		}
	}
}

### main ###
my $user = shift or die;
   $user =~ /\A${REGEX_USERLINK}\z/ or die;
local $_ = <>;

walk_books('newbook_', $REGEX_NEWBOOKS, $user);
walk_books('contbook', $REGEX_CONTBOOKS, $user);
if(/${REGEX_NEIGHBORS}/) {
	local $_ = $1;
	while(/${REGEX_NEIGHBOR_LINK_SCREEN}/g) {
		my ($link, $screen) = (&abspath_to_link($1), $2);
		print "neighbor\t${user}\t${link}\t${screen}\n";
	}
}

__END__
