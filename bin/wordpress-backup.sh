#!/usr/bin/env bash
# vim:set ts=8 sw=2 sts=2 et:

# To run this at 05h00 every day, put this in the crontab:
# 0 5 * * * ~/.dotfiles/bin/vhost-backup

# Create a MySQL options file at $MYSQL_OPTIONS_PATH that looks like this:
#
#   [client]
#   host=host
#   database=database
#   user=user
#   password=password

# To restore a database backup, create "$MYSQL_DATABASE" then run:
#   $ bunzip2 -c "$SQLDUMP_PATH" | \
#     mysql --defaults-file="$MYSQL_OPTIONS_PATH" "$MYSQL_DATABASE"

set -o errexit
set -o nounset
set -o pipefail

VHOST_NAME=${VHOST_NAME:?VHOST_NAME is undefined}
MYSQL_DATABASE=${MYSQL_DATABASE:?MYSQL_DATABASE is undefined}
NUM_DAYS_TO_KEEP_BACKUPS=${NUM_DAYS_TO_KEEP_BACKUPS:?NUM_DAYS_TO_KEEP_BACKUPS is undefined}

BACKUP_DIR="${HOME}/backup/${VHOST_NAME}"
HTDOCS_DIR="${HOME}/web/${VHOST_NAME}"
MYSQL_OPTIONS_PATH="${HOME}/mysql/${VHOST_NAME}"

TIMESTAMP="$(date +%Y-%m-%d-%H%M)"
BACKUP_NAME="${VHOST_NAME}-${TIMESTAMP}"
TARBALL_NAME="${BACKUP_NAME}.tar.bz2"
SQLDUMP_NAME="${BACKUP_NAME}.sql.bz2"
TARBALL_PATH="${BACKUP_DIR}/${TARBALL_NAME}"
SQLDUMP_PATH="${BACKUP_DIR}/${SQLDUMP_NAME}"

if [[ -e "$TARBALL_PATH" ]]; then
  echo "The tarball already exists: $TARBALL_PATH"
  exit 1
fi

if [[ -e "$SQLDUMP_PATH" ]]; then
  echo "The MySQL dump already exists: $SQLDUMP_PATH"
  exit 1
fi

echo "Starting backup for $VHOST_NAME at $(date)"

mkdir -p "$BACKUP_DIR"

echo "Writing tarball at $TARBALL_PATH"

pushd "$HTDOCS_DIR"/.. > /dev/null
tar cjf "$TARBALL_PATH" "$VHOST_NAME"
popd > /dev/null

echo "Tarball size is $(du -s -m $TARBALL_PATH | cut -f 1) MiB"

echo "Writing MySQL dump at $SQLDUMP_PATH"

mysqldump \
  --defaults-file="$MYSQL_OPTIONS_PATH" \
  --add-drop-table \
  "$MYSQL_DATABASE" \
  | bzip2 -c > "$SQLDUMP_PATH"

echo "MySQL dump size is $(du -s -k $SQLDUMP_PATH | cut -f 1) KiB"

echo "Removing backups older than $NUM_DAYS_TO_KEEP_BACKUPS days"

find "$BACKUP_DIR" -type f -mtime "+${NUM_DAYS_TO_KEEP_BACKUPS}d" \
  -exec rm -v -f '{}' \;

echo "Total size of backup directory is $(du -s -m $BACKUP_DIR | cut -f 1) MiB"

echo "Backup finished at $(date)"
