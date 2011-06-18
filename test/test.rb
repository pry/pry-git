direc = File.dirname(__FILE__)

require 'rubygems'
require "#{direc}/../lib/pry-git"
require 'bacon'

puts "Testing pry-git version #{PryGit::VERSION}..." 
puts "Ruby version: #{RUBY_VERSION}"

describe PryGit do
end

