# pry-git.rb
# (C) John Mair (banisterfiend); MIT license

require "pry-git/version"
require "pry"
require 'grit'
require 'diffy'
require 'tempfile'

module PryGit
  module GitHelpers
    def get_file_from_commit(path)
      git_root = find_git_root(File.dirname(path))
      repo = Grit::Repo.new(git_root)
      head = repo.commits.first
      tree_names = relative_path(git_root, path).split("/")
      start_tree = head.tree
      blob_name = tree_names.last
      tree = tree_names[0..-2].inject(start_tree)  { |a, v|  a.trees.find { |t| t.basename == v } }
      blob = tree.blobs.find { |v| v.basename == blob_name }
      blob.data
    end

    def method_code_from_head(meth)
      code = get_file_from_commit(meth.source_location.first)
      search_line = meth.source.lines.first.strip
      _, start_line = code.lines.to_a.each_with_index.find { |v, i| v.strip == search_line }
      start_line
      [Pry.new(:input => StringIO.new(code.lines.to_a[start_line..-1].join)).r(target), start_line + 1]
    end

    def relative_path(root, path)
      path =~ /#{root}\/(.*)/
      $1
    end

    # return the git top level for a give directory
    def find_git_root(dir)
      git_root = "."
      Dir.chdir dir do
        git_root =  `git rev-parse --show-toplevel`.chomp
      end

      raise "No associated git repository found!" if git_root =~ /fatal:/
      git_root
    end
  end

  Commands = Pry::CommandSet.new do

    create_command "git blame", "Show blame for a method (for method in HEAD)" do
      include GitHelpers

      def options(opt)
        method_options(opt)
      end

      def process
        raise CommandError, "Could not find method source" unless method_object.source

        meth = method_object

        file_name = meth.source_location.first
        code, start_line = method_code_from_head(meth)

        git_root = find_git_root(File.dirname(file_name))

        repo = Grit::Repo.new(git_root)
        num_lines = code.lines.count
        authors = repo.blame(relative_path(git_root, file_name), repo.head.commit).lines.select do |v|
          v.lineno >= start_line && v.lineno <= start_line + num_lines
        end.map do |v|
          v.commit.author.output(Time.new).split(/</).first.strip
        end

        lines_with_blame = []
        code.lines.zip(authors) { |line, author| lines_with_blame << ("#{author}".ljust(20) + colorize_code(line)) }
        output.puts lines_with_blame.join
      end
    end

    create_command "git diff", "Show the diff for a method (working directory vs HEAD)" do
      include GitHelpers

      def options(opt)
        method_options(opt)
      end

      def process
        output.puts colorize_code(Diffy::Diff.new(method_code_from_head(method_object).first, method_object.instance_variable_get(:@method).source))
      end
    end

    create_command "git add", "Add a method to index" do
      include GitHelpers

      def options(opt)
        method_options(opt)
      end

      def process
        meth = method_object.instance_variable_get(:@method)

        file_name = meth.source_location.first

        git_root = find_git_root(File.dirname(file_name))
        repo = Grit::Repo.new(git_root)

        rel_file_name = relative_path(git_root, meth.source_location.first)
        file_data = get_file_from_commit(file_name)
        code, start_line = method_code_from_head(meth)
        end_line = start_line + code.lines.count

        before_code = file_data.lines.to_a[0..(start_line - 2)]
        after_code = file_data.lines.to_a[end_line - 1..-1]

        final_code = before_code << meth.source.lines.to_a << after_code

        t = Tempfile.new("tmp")
        t.write final_code.join
        t.close

        sha1 = `git hash-object -w #{t.path}`.chomp
        system("git update-index --cacheinfo 100644 #{sha1} #{rel_file_name}")
      end
    end

  end
end

Pry.commands.import PryGit::Commands
