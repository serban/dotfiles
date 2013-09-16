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

set -e  # Die if any command fails
set -u  # Die if an unset variable is used

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

mkdir -p "$BACKUP_DIR"

pushd "$HTDOCS_DIR"/.. > /dev/null
tar cjf "$TARBALL_PATH" "$VHOST_NAME"
popd > /dev/null

mysqldump \
  --defaults-file="$MYSQL_OPTIONS_PATH" \
  --add-drop-table \
  "$MYSQL_DATABASE" \
    wp_commentmeta \
    wp_comments \
    wp_links \
    wp_options \
    wp_postmeta \
    wp_posts \
    wp_term_relationships \
    wp_term_taxonomy \
    wp_terms \
    wp_usermeta \
    wp_users \
  | bzip2 -c > "$SQLDUMP_PATH"

# Remove old backups to save space
find "$BACKUP_DIR" -type f -mtime "+${NUM_DAYS_TO_KEEP_BACKUPS}d" \
  -exec rm '{}' \;
