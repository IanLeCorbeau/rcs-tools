# $Ragnarok$
# Module to parse config.

package EOD::conf;

use strict;
use warnings;
use File::HomeDir;
use Config::General;
our @EXPORT_OK = qw($username $sign $verify_sig $pubkey_dir);

my $conffile	= File::HomeDir->my_home . '/.rcs.conf';

my $conf = Config::General->new(
	-ConfigFile		=> $conffile,
	-SplitPolicy		=> 'custom',
	-SplitDelimiter		=> '\s+=\s+',
	-InterPolateVars	=> 1,
	-AutoTrue		=> 1
);

my %config	= $conf->getall;
our $username	= $config{'USERNAME'};
our $sign	= $config{'SIGN'};
our $verify_sig	= $config{'VERIFY_SIG'};
our $pubkey_dir	= $config{'PUBKEY_DIR'};

1;
