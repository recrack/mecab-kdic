#!/usr/bin/ruby
# coding: utf-8

# kdic.txt 로부터 kdic.csv 를 생성하는 소스이다.
require 'csv'

i = 0
col_size = 10

CSV.foreach("kdic.txt") do |row|
    begin
        puts(row[0] + ",0"*3 + "," + row[1..-1].join(",") + ",*" * (col_size - row.size))
    rescue
        raise "at line #{i+1} column size > #{col_size}"
    end
    i += 1
end
