# Effuse

Tool for symlinking dotfiles.

## Install

```
gem install effuse
```

## Usage

So, say you have all your precious dotfiles in a nice little git
repository or Dropbox folder or whatever else you might use. It's a
great way to be able to use your configurations on multiple computers,
but how do you get those configurations out of the repository and into
your filesystem?

The answer: symbolic links. Lots of them. And how do you go about
creating all these symlinks? Sure, you could create each one by hand,
but you're a busy person and obviously don't have time for such menial
tasks. Luckily, you've just discovered Effuse!

Just run `effuse` in your dotfiles repository and it will automagically
create symlinks to all your configurations in your home directory!

```sh
dotfiles $ ls -a
. .. .vimrc .zshrc
dotfiles $ effuse
'/home/you/.vimrc' -> '/home/you/dotfiles/.vimrc'
'/home/you/.zshrc' -> '/home/you/dotfiles/.zshrc'
```

Your configurations don't go in your home directory? No problem! Just
run `effuse /path/` and the symlinks will be created wherever your heart
desires.

Would you rather import a dotfile from your system into your repository
than replace it? No problem, just use `effuse --import`.

```sh
dotfiles $ ls -a ~
. .. .vimrc .zshrc
dotfiles $ touch .vimrc .zshrc
dotfiles $ effuse --import
'/home/you/.vimrc' already exists. Import it? [Y/n] y
'/home/you/.vimrc' -> '/home/you/dotfiles/.vimrc'
'/home/you/.zshrc' already exists. Import it? [Y/n] y
'/home/you/.zshrc' -> '/home/you/dotfiles/.zshrc'
```

Symlinks aren't working out for you? Effuse has got you covered. Just
run `effuse --clean` in your dotfiles repository and it will remove all
those nasty symlinks it created before.

Don't want to symlink a certain bothersome file? Why not tell Effuse
your opinion on the matter using `effuse --exclude file`?

```sh
dotfiles $ ls -a
. .. .vimrc .zshrc
dotfiles $ effuse --exclude .vimrc
'/home/you/.zshrc' -> '/home/you/dotfiles/.zshrc'
```

Maybe you don't like to have the files in your dotfiles repository named
with leading dots. If that's what floats your boat, you can have Effuse
prefix the symlink paths using `effuse --prefix .`.

```sh
dotfiles $ ls
vimrc zshrc
dotfiles $ effuse --prefix .
'/home/you/.vimrc' -> '/home/you/dotfiles/vimrc'
'/home/you/.zshrc' -> '/home/you/dotfiles/zshrc'
```

Now, say you want to create symlinks in `~/foo`, you want to exclude
`*.bak` files, and you want to prefix your symlink paths with `.`.
Specifying all those on the command line every time you run Effuse
sounds horrible, doesn't it? Luckily, you can use an `effuse.yml` file
instead!

```yaml
destination: ~/foo
prefix: .
exclude:
  - '*.bak'
```

### Command Line

```
usage: effuse [OPTIONS...] [DEST]
    -i, --import                     Import existing files
    -c, --clean                      Remove symlinks

    -y, --no-confirm                 Do not ask before replacing files
    -n, --no-backup                  Do not create backup files

        --exclude GLOB               Exclude GLOB from symlinking
        --include GLOB               Include GLOB in symlinking

    -p, --prefix                     Prefix symlink paths with PREFIX

    -v, --verbose                    Show verbose output

        --version                    Show version
    -h, --help                       Show this message
```

### YAML File

The `effuse.yml` file may contain the following keys:

* `destination`: Symlink destination directory (defaults to `~`)
* `prefix`: Symlink path prefix
* `exclude`: Array of globs to exclude from symlinking
* `include`: Array of globs to not exclude from symlinking

### Migrating from 2.0 to 2.1

Version 2.1 of Effuse deprecates the use of `.effuseignore` files in
favor of `effuse.yml` files. To migrate, add each line of the ignore
file to the `exclude` array of the YAML file.

`.effuseignore`:

```
*.bak
foo
```

`effuse.yml`:

```yaml
exclude:
  - '*.bak'
  - 'foo'
```

## License

Copyright © 2012-2013, Curtis McEnroe <programble@gmail.com>

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
