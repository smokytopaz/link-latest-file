# link-latest-file

bash script, intended to be used with crontab.

This script is designed to be used when a local and external
backup are required.  Instead of backing up n days of files
to the external device daily, this script will create a sym link
to the most recently modified file in the specified directory.

The external backup will then have the most recent backup every
time that it is run.  The local server will also maintain its'
backups locally.

Usage:

latestLink.sh path/to/directory newDirectory

Run the command specifying the path of the files you want to be
backed up.  Specify the name and path of the new directory the
external backup will be pointing to.
