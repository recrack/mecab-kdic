# coding: utf-8
# http://www.unicode.org/versions/Unicode6.1.0/ch03.pdf

module HangulUtils

SBase = 0xAC00
LBase = 0x1100
VBase = 0x1161
TBase = 0x11A7
LCount = 19
VCount = 21
TCount = 28
NCount = VCount * TCount # 588
SCount = LCount * NCount # 11172

# s: hangul syllable
def self.decompose_hangul(s)
    s_index = s.ord - SBase
    return s if (s_index < 0 || s_index >= SCount)
    result = ""
    l = LBase + s_index / NCount
    v = VBase + (s_index % NCount) / TCount
    t = TBase + s_index % TCount
    result << l << v
    result << t if (t != TBase)
    return result
end

# source: string
def self.compose_hangul(source)
    len = source.length
    return "" if len.zero?
    result = ""
    last = source[0]
    # copy first char
    result << last
    for i in 1...len
        ch = source[i]
        # 1. check to see if two current characters are L and V
        l_index = last.ord - LBase
        if (0 <= l_index && l_index < LCount)
            v_index = ch.ord - VBase
            if (0 <= v_index && v_index < VCount)
                # make syllable of form LV
                last = [(SBase + (l_index * VCount + v_index) * TCount)].pack("U")
                result[result.length-1] = last # reset last
                next # discard ch
            end
        end
        # 2. check to see if two current characters are LV and T
        s_index = last.ord - SBase
        if (0 <= s_index && s_index < SCount && (s_index % TCount) == 0)
            t_index = ch.ord - TBase
            if (0 < t_index && t_index < TCount)
                # make syllable of form LVT
                last = [last.ord + t_index].pack("U")
                result[result.length-1] = last # reset last
                next # discard ch
            end
        end
        # if neither case was true, just add the character
        last = ch
        result << ch
    end
    return result
end

# s: hangul syllable
def self.get_hangul_name(s)
    s_index = s.ord - SBase
    if (0 > s_index || s_index >= SCount)
        raise ArgumentError.new("Not a Hangul Syllable: " + s)
    end
    result = ""
    l_index = s_index / NCount
    v_index = (s_index % NCount) / TCount
    t_index = s_index % TCount
    return ("HANGUL SYLLABLE " + JAMO_L_TABLE[l_index] +
        JAMO_V_TABLE[v_index] + JAMO_T_TABLE[t_index])
end

JAMO_L_TABLE = [
    "G", "GG", "N", "D", "DD", "R", "M", "B", "BB",
    "S", "SS", "", "J", "JJ", "C", "K", "T", "P", "H"
]

JAMO_V_TABLE = [
    "A", "AE", "YA", "YAE", "EO", "E", "YEO", "YE", "O",
    "WA", "WAE", "OE", "YO", "U", "WEO", "WE", "WI",
    "YU", "EU", "YI", "I"
]

JAMO_T_TABLE = [
    "", "G", "GG", "GS", "N", "NJ", "NH", "D", "L", "LG", "LM",
    "LB", "LS", "LT", "LP", "LH", "M", "B", "BS",
    "S", "SS", "NG", "J", "C", "K", "T", "P", "H"
]
end # of module
