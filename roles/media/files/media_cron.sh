SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin
@daily plex media_backup > /tmp/media_backup.log 2>&1
