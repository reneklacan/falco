# -*- encoding : utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)

require 'falco'

include Falco

puts Compiler.compile(Parser.parse_file(ARGV[0]))
