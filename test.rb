#!/usr/bin/ruby
# coding: utf-8

require 'MeCab'
#require './hangul-utils.rb'

# "안녕하십니까"는 안녕 + 하 + 시 + ㅂ니까 로 분해가 되므로 그 처리를 위해
# kdic.csv 의 표층어(가장 왼쪽줄의 단어)는 NFD 형태로 입력되어 있다.
#
# NOTE
# 따라서 mecab를 실제 사용할 경우
# 한글 글자를 NFD로 풀어서 MeCab에 입력하고
# 반환된 결과값을 NFC로 묶어줘야 한다.
# 아래는 그 예이다.

# TODO
# 초성자음 <---> 종성자음 코드로 상호 변환하는 코드가 필요한다.

m = MeCab::Tagger.new ("-d ./final")

if ARGV[0].nil?
    puts "usage: ruby test.rb filename"
    exit 0
end

f = File.new(ARGV[0], "r")

f.each_line do |line|
    #nfd = ""
    # 한글 글자를 풀어준다.(NFD)
    #line.each_char {|ch| nfd << HangulUtils.decompose_hangul(ch)}
    line.strip!
    unless line.empty?
        puts m.parse(line)
        #ascii_nfd = m.parse(nfd)
        #utf8_nfd = ascii_nfd.force_encoding("UTF-8")
        # 한글 글자를 묶어준다.(NFC) 그리고 화면에 출력한다
        #untrusted = HangulUtils.compose_hangul(utf8_nfd)
        # TODO 받침으로 분해되는 형태소가 있을 때마다
        # 소스를 수정해야 하고 기억(ㄱ),니은(ㄴ)..은 명사로 사용되므로
        # 혼동을 피하기 위해서라도 전체적으로 코드를 간결화할 필요가 있다.
        # 일단은 아래처럼 사용하도록 한다.
        #trusted = untrusted.gsub("ᆸ니까", "ㅂ니까")
        #puts trusted
    end
end
