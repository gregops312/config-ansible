#!/usr/bin/env bash

# Explanation of possible values from -i flag
# https://stackoverflow.com/a/36851784/5494790

rsync -aiv \
  --delete \
  --include='movies/***' \
  --include='music/***' \
  --include='personal_media/***' \
  --include='tv_shows/***' \
  --exclude='*' \
  /data/media/ /data/media_backup
