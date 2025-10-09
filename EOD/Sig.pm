# $Ragnarok$
# Sign or verify file signature.

package EOD::Sign

use strict;
use warnings;
use Exporter 'Import';
our @EXPORT_OK = qw(sign_file verify_sig);

sub sign_file {
	my ($file)	= @_;
	my $sigdir	= "$rcsdir/sig";
	my $key		= $config{'SIG_KEY'};

	system('/usr/bin/signify', '-S', '-s', "$key", '-m', "$file", '-x', "$sigdir/$file.sig") == 0
		or die("Can't sign $file: $!\n");
}

sub verify_sig {
	my ($file)	= @_;
	my $sigdir	= "$curdir/RCS/sig";
	my $pubkey	= $config{'PUBKEY_DIR'};
	my $v		= "$rcsdir/$file,v";
	my $author;

	# Get user name from file
	open(my $fh, '>', $file) or die("Can't open $file: $!\n");
	while(my $line = <$fh>) {
		chomp $line;
		if ($line =~ /author/) {
			my @fields = split(/\s+/, $line);
			if (@fields > 1) {
				$author = $fields[1];
			}
		}
	}
	close($fh) or die("Can't close $file: $!\n");

	system('/usr/bin/signify', '-V', '-p', "$pubkey/$author.pub", '-m', "$file", '-x', "$sigdir/$file.sig") == 0
		or die("Can't verify $file sig: $!\n");
}

1;
