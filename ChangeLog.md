# Change Log

## 2.1.0 (November 10 2013)

 * Added support for `effuse.yml` files
 * Deprecated `.effuseignore` files
 * Added `--version` option

## 2.0.1 (May 14 2013)

 * Fix: Backup files by appending `.effuse`
 * Fix: Ignore effuse backup files

## 2.0.0 (May 13 2013)

 * Replace existing files by default
 * Added `--import` option to import existing files
 * Changed `--noconfirm` to `--no-confirm`
 * Backup files to `.file.effuse`
 * Removed short forms of `--exclude` and `--include` options

## 1.1.1 (March 12 2013)

 * Dropped Ruby 1.8 compatibility

## 1.1.0 (April 28 2012)

 * Added `--prefix`
 * Fix: Ruby 1.8 compatibility in reading `.effuseignore`

## 1.0.0 (April  9 2012)

 * Added `--no-backup`
 * Support for `.effuseignore`

## 0.3.2 (March 31 2012)

 * Fix: Exclude `.*~` files from symlinking

## 0.3.1 (March 29 2012)

 * Fix: Check if destination directory is current directory

## 0.3.0 (January 23 2012)

 * Added `--noconfirm` option

 * Fix: Ruby 1.8 compatibility

## 0.2.0 (January 22 2012)

 * Added `--include` option

 * Fix: Ignore `.git`, `.gitignore`, `.gitmodules` instead of `.git*`

## 0.1.2 (January 21 2012)

 * Fix: Ruby 1.8 compatibility

## 0.1.1 (January 21 2012)

 * Fix: Ruby 1.8 compatibility
