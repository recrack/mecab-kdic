#!/usr/bin/ruby
# coding: utf-8

# pos-id.def 생성하는 소스이다.

i = 0
col_size = 4

DATA.each_line do |line|
    row = line.chomp.split(",")
    begin
        puts(row.join(",") + ",*" * (col_size - row.size) + " " + i.to_s)
    rescue
        raise "at line #{i+1} column size > #{col_size}"
    end
    i += 1
end


__END__
명사,일반명사
명사,고유명사
명사,의존명사
대명사
수사
동사
형용사
보조용언
지정사,긍정지정사
지정사,부정지정사
관형사
부사,일반부사
부사,접속부사
감탄사
조사,주격조사
조사,보격조사
조사,관형격조사
조사,목적격조사
조사,부사격조사
조사,호격조사
조사,인용격조사
조사,보조사
조사,접속조사
어미,선어말어미
어미,종결어미
어미,연결어미
어미,명사형전성어미
어미,관형형전성어미
접두사,체언접두사
접미사,명사파생접미사
접미사,동사파생접미사
접미사,형용사파생접미사
어근
기호
