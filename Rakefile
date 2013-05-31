require "pathname"

#
# Basic approach adapted from Ryan Bates' dotfiles.
# https://github.com/ryanb/dotfiles/blob/master/Rakefile
#

FILES = FileList.new('*') { |list| list.exclude("Rakefile", ".git") }
OPTIONS = { replace_all: false }

desc "Install the dotfiles into user's home directory"
task :install do
  FILES.each do |file|
    install_file(Pathname.new(file))
  end
end

def install_file(file)
  target = Pathname.new(ENV["HOME"]) + ".#{file}"
  if target.exist?
    maybe_replace(file, target)
  else
    link_file(file, target)
  end
end

def maybe_replace(file, target)
  if File.identical?(target.to_path, file.to_path)
    puts "Identical: #{target}"
    return
  end

  if target.directory? && !target.symlink?
    process_directory(file)
  else
    maybe_replace_file(file, target)
  end
end

def process_directory(file)
  file.each_child { |f| install_file(f) }
end

def maybe_replace_file(file, target)
  if prompt_to_replace(target)
    replace_file(file, target)
  else
    puts "Skipping #{target}"
  end
end

def prompt_to_replace(target)
  return true if OPTIONS[:replace_all]

  print "Overwrite #{target}? [ynaq] "
  case $stdin.gets.chomp
  when 'q'
    puts "Quitting"
    exit
  when 'a'
    OPTIONS[:replace_all] = true
    true
  when 'y'
    true
  else
    false
  end
end

def replace_file(file, target)
  target.delete
  link_file(file, target)
end

def link_file(file, target)
  puts "Linking #{target}"
  target.dirname.mkpath

  fail "#{target} exists and is not a symlink" if target.exist? && !target.symlink?
  target.unlink if target.exist?
  target.make_symlink(file.expand_path)
end
