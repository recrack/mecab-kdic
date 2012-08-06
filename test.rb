#!/usr/bin/ruby
# coding: utf-8

require 'MeCab'

m = MeCab::Tagger.new ("-d ./final")

f = File.new("./text/채만식-태평천하.txt", "r")
f.each_line do |line|
    print m.parse (line) unless line.chomp.empty?
end
