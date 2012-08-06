#!/usr/bin/ruby
# coding: utf-8
#
# kdic.txt 로부터 kdic.csv 를 생성하는 소스이다.
#
#' 안녕하십니까' 를 분해하면
#
# 안녕   일반명사
# 하     동사파생접미사
# 시     선어말어미
# ㅂ니까 종결어미
#
# 이렇게 분해가 되는데, 'ㅂ니까' 같은 형태 때문에 한글을 nfd 로 풀어서 corpus,
# kdic.csv 를 작성해야 한다.
#
# 실제 형태소 분석기를 사용할 때에는 "안녕하십니까" 문장을 nfd 로 풀어서 mecab에
# 입력하여 결과값을 받아 nfc 로 묶어서 화면에 출력해줘야 한다.

require 'csv'
require './hangul-utils.rb'

i = 0
col_size = 10

# NOTE
# 형태소로 분리했을 때 받침ㄴ,ㅂ 등이 나왔다면 아래 테이블을 이용하여
# 받침으로 변환해주어야 한다.
# 단, 기억(ㄱ), 니은(ㄴ)... 이렇게 사용되었을 경우에는 명사이므로
# 변환해서는 안 된다.
TABLE = {
    "ㄴ" => "\u11ab",
    "ㅂ" => "\u11b8" # 받침ㅂ
}

CSV.foreach("kdic.txt") do |row|
    begin
        nfd = ""
        row[0].each_char do |ch|
            case ch.ord
            # TODO 받침으로 사용되는 모든 형태소를 알아내어
            # 그 형태소만 변환시켜야 한다.
            when 12593..12622 # "ㄱ".."ㅎ"
                nfd << TABLE[ch]
            else
                nfd << HangulUtils.decompose_hangul(ch)
            end
        end
        puts(nfd + ",0"*3 + "," + row[1..-1].join(",") + ",*" * (col_size - row.size))
    rescue
        raise "at line #{i+1} column size > #{col_size}"
    end
    i += 1
end
