<!-- $Ragnarok: README.md,v 1.1 2025/09/23 22:20:30 lecorbeau Exp $ -->

# rcs-tools

Extra tools for rcs (Revision Control System).

## Usage

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


