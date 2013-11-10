require 'fileutils'
require 'yaml'
require 'optparse'

class Effuse
  VERSION = '2.0.1'

  def initialize
    @dest_dir = Dir.home
    @import   = false
    @clean    = false
    @confirm  = true
    @backup   = true
    @prefix   = ''
    @verbose  = false
    @exclude  = %w[*~ .*~ .*.sw? .effuseignore effuse.yml *.effuse .*.effuse
                   .git .gitignore .gitmodules]

    ignore_file
    effuse_file
    options

    vputs self.inspect
  end

  def ignore_file
    return unless File.file? '.effuseignore'
    puts 'warning: ignore file is deprecated, use effuse.yml instead'
    File.readlines('.effuseignore').each do |glob|
      @exclude << glob.chomp
    end
  end

  def effuse_file
    return unless File.file? 'effuse.yml'
    yaml = YAML.load_file('effuse.yml')

    if yaml.include? 'destination'
      @dest_dir = File.expand_path(yaml['destination'])
    end
    @prefix = yaml['prefix'] if yaml.include? 'prefix'

    exclude = yaml['exclude'] || yaml['ignore']
    @exclude.concat(exclude) if exclude
    @exclude -= yaml['include'] if yaml.include? 'include'
  end

  def options
    OptionParser.new do |o|
      o.banner = 'usage: effuse [OPTIONS...] [DEST]'

      o.on('-i', '--import', 'Import existing files') do
        @import = true
      end
      o.on('-c', '--clean', 'Remove symlinks') do
        @clean = true
      end

      o.separator ''

      o.on('-y', '--no-confirm', 'Do not ask before replacing files') do
        @confirm = false
      end
      o.on('-n', '--no-backup', 'Do not create backup files') do
        @backup = false
      end

      o.separator ''

      o.on('--exclude GLOB', 'Exclude GLOB from symlinking') do |glob|
        @exclude << glob
      end
      o.on('--include GLOB', 'Include GLOB in symlinking') do |glob|
        @exclude.delete(glob)
      end

      o.separator ''

      o.on('-p', '--prefix', 'Prefix symlink paths with PREFIX') do |prefix|
        @prefix = prefix
      end

      o.separator ''

      o.on('-v', '--verbose', 'Show verbose output') do
        @verbose = true
      end

      o.separator ''

      o.on_tail('--version', 'Show version') do
        puts "effuse #{VERSION}"
        exit
      end
      o.on_tail('-h', '--help', 'Show this message') do
        puts o
        exit
      end
    end.parse!
    @dest_dir = ARGV.first if ARGV.first
  end

  def vputs(s)
    puts(s) if @verbose
  end

  def confirm? s
    return true unless @confirm
    loop do
      print "#{s} [Y/n] "
      input = $stdin.gets.chomp
      return true if input.empty? || input[0].downcase == ?y
      return false if input[0].downcase == ?n
    end
  end

  def backup(src)
    if @backup
      vputs "renaming '#{src}' -> '#{src}.effuse'"
      File.rename(src, src + '.effuse')
    else
      vputs "deleting '#{src}'"
      File.delete(src)
    end
  end

  def scan
    dirs = ['.']
    files = {}

    dirs.each do |dir|
      vputs "scanning '#{dir}'"
      Dir.foreach(dir) do |entry|
        next if %w[. ..].include? entry

        path = File.join(dir, entry)

        if @exclude.any? {|g| File.fnmatch(g, entry) }
          vputs "excluding '#{path}'"
          next
        end

        if File.directory? path
          dirs << path
          next
        end

        vputs "adding '#{path}'"
        relpath = @prefix + File.join(path.split('/').drop(1))
        files[File.absolute_path(path)] = File.join(@dest_dir, relpath)
      end
    end

    files
  end

  def clean(files)
    files.each do |src, dest|
      if File.exist?(dest) && File.identical?(src, dest)
        puts dest
        File.delete(dest)
      else
        vputs "'#{dest}' not symlinked"
      end
    end
  end

  def symlink(files)
    files.each do |src, dest|
      if File.exist? dest
        if File.identical? src, dest
          vputs "'#{dest}' already symlinked"
          next
        elsif @import
          if confirm? "'#{dest}' already exists. Import it?"
            backup(src)
            vputs "renaming '#{dest}' -> '#{src}'"
            File.rename(dest, src)
          else
            vputs "skipping '#{dest}'"
            next
          end
        else # Replace destination file
          if confirm? "'#{dest}' already exists. Replace it?"
            backup(dest)
          else
            vputs "skipping '#{dest}'"
            next
          end
        end
      end

      puts "'#{dest}' -> '#{src}'"
      FileUtils.mkdir_p(File.dirname(dest))
      File.symlink(src, dest)
    end
  end

  def execute
    if File.identical? @dest_dir, '.'
      puts 'error: destination directory is current directory'
      exit 1
    end

    if @clean
      clean(scan)
    else
      symlink(scan)
    end
  end
end
