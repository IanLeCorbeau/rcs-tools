# $Ragnarok$
# Generate diff after a check in.

package EOD::Diff

use strict;
use warnings;
use Cwd qw();
use Capture::Tiny 'capture_stdout';
our @EXPORT_OK	= qw(do_diff);

my $curdir	= Cwd::cwd();
my $diffdir	= "$curdir/RCS/diffs";

# Create a diff between new and previous revision.
sub do_diff {
	my ($file) = @_;

	my $curdir	= Cwd::cwd();
	my $diffdir	= "$curdir/RCS/diffs";
	my $v		= "$curdir/RCS/$file,v";
	my $head;
	my $prev;

	open(my $fh, '<', $v) or die("Can't open log file: $!\n");
	
	while(my $line = <$fh>) {
		chomp $line;
		if (!$head && $line =~ /head\s+(\d+\.\d+)/) {
			$head = $1;
		}
		if (!$prev && $line =~ /next\s+(\d+\.\d+)/) {
			$prev = $1;
		}
		last if $head && $prev;
	}
	close($fh) or die("Can't close file: $!\n");
	
	# Don't try to diff if this is revision 1.1
	if ($head eq 1.1) {
		return;
	}

	open(my $diff, '>', "$diffdir/$file-$head.diff") or die("Open Diff Failed: $!\n");
	print($diff capture_stdout {
			system('/usr/bin/rcsdiff', '-u', "-r$prev", "-r$head", "$file");
			return;
		}
	);
	close($diff) or die("Close Diff Failed: $!\n");
}

1;
