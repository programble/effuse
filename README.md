# Effuse

A tool for managing symlinks

## Install

```
gem install effuse
```

## Usage

So, say you have all your precious dotfiles in a nice little git repository or
Dropbox folder or whatever else you might use. It's a great way to be able to
use your configurations on multiple computers, but how do you get those
configurations out of the repository and into your filesystem?

The answer: symbolic links. Lots of them. And how do you go about creating all
these symlinks? Sure, you could create each one by hand, but you're a busy
person and obviously don't have time for such menial tasks. Luckily, you've
just discovered Effuse!

Just run `effuse` in your dotfiles repository and it will automagically create
symlinks to all your configurations in your home directory!

Your configurations don't go in your home directory? No problem! Just run
`effuse /path/` and the symlinks will be created wherever your heart desires.

Symlinks aren't working out for you? Effuse has got you covered. Just run
`effuse --clean` in your dotfiles repository and it will remove all those nasty
symlinks it created before.

Don't want to symlink a certain bothersome file? Why not tell Effuse your
opinion on the matter using `effuse -e file`? Or why not give it a stern
talking to using a `.effuseignore` file? Just put one file glob to exclude per
line in there and never worry again.

```
Usage: effuse [OPTION...] [DEST]
    -c, --clean                      Remove symlinks

    -e, --exclude GLOB               Exclude GLOB from symlinking
    -i, --include GLOB               Include GLOB in symlinking

    -y, --noconfirm CHOICE           Assume CHOICE on file conflicts
    -n, --no-backup                  Do not create backup files

    -p --prefix PREFIX               Prefix relative paths with PREFIX

    -v, --verbose                    Show verbose output
    -h, --help                       Show this message
```

## License

Copyright (c) 2011, Curtis McEnroe <programble@gmail.com>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

