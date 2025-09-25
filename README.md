<!-- $Ragnarok: README.md,v 1.6 2025/09/25 15:28:22 lecorbeau Exp $ -->

# rcs-tools

Extra tools for rcs (Revision Control System).

## Usage

In order to work, ensure that the following Perl modules are available
on your system:

* Config::General
* File::Homedir
* File::Path
* Capture::Tiny

### .rcs.conf

These tools parse options from a config file that should be located in
`$HOME`. The options are as follow:

* `USERNAME`: Name of the rcs user. This is mandatory for the tools to work.

* `SIGN`: If set to true, this will sign every file with
[signify(1)](http://man.openbsd.org/signify) whenever rci is run. See
the `Signing` section below.

* `SIG_KEY`: full path to the signify `*.sec` key.

* `VERIFY_SIG`: if set to true, file signature will be verified with signify
before a checkout is performed when running `rco`.

* `PUBKEY_DIR`: path to the directory containing signify `*.pub` keys.

### Commands

* `rci`: wrapper script around the `ci` command. Only takes file names
as argument. As with the default `ci` command, will checkin one or more
files. It also passes the `-u` flag to ensure that a read-only copy of
the file remains, as well as `-wUSERNAME`. After check in, a log file
and a diff between the latest and previous revisions will be created in
`RCS/logs` and `RCS/diffs` respectively. Will also sign file if
`SIGN = true` in `.rcs.conf`.

* `rco`: wrapper around `co`. Passes the `-l` file to lock the revision,
as well as `-wUSERNAME`. If `VERIFY_SIG` is set to true, will verify the
file's signature with signify before check out.

The following commands are not yet implemented:

* `rcl`: clean up the RCS/diffs directory. For example, `rcl -r1.2 -r1.50 file1`
would concatenate all diffs from revision 1.2 up to, and including,
revision 1.50 in a single file named `file1.hist.diff`, then delete the
individual diffs.

* `rcsgit`: push rcs revisions/commits to git mirror.

* `rcsweb` & `rcsget`: creates html pages out of files under rcs' control
to host online, and fetch whole repos, dirs or single files, respectively.

## Signing and verifying files/revisions

Files can be automatically signed with signify upon checkin with `rci`,
and their signature verified upon checkout with `rco`.

### Set up for automatic signing

Create a new key pair:

    signify -G -p USERNAME.pub -s USERNAME.sec

Replace `USERNAME` with the USERNAME defined in .rcs.conf. Then, place
the `.sec` key in a directory of your choice (keep it safe).

In `.rcs.conf`, set `SIGN = true` and add the full path to the sec key's
directory to `.rcs.conf`, eg: `SIG_KEY = /home/user/.sig`. *Do not add
the name of the key, only the directory where the key resides*.

That's it. Your `.pub` key can be shared and used to verify rcs files at
check out time.

**Caveat: you will need to enter your key's passphrase whenever a file
is signed unless you passed the -n option when creating your new key
pair. Not using a passphrase is not recommended, only do so if you
understand the potential consequences.**

### Set up for automatic sig verification

Save a user's (or your own) `.pub` key somewhere appropriate, then in
`.rcs.conf`:

    VERIFY_SIG = true
    PUBKEY_DIR = /path/to/pubkey-dir

Simple as that.

## TODO

[] Create module to load config values instead of loading them in every
single scripts.
