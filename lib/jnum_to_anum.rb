require "jnum_to_anum/version"
class String
  def kansuji_to_num
    s = self.tr('一二三四五六七八九〇壱弐参０-９ａ-ｚＡ-Ｚ','12345678901230-9a-zA-Z').gsub(/[,.]+/,"")
    exception = s.match(/^([0-9]+)(百万|千)\z/)
    if exception #例外  売り上げなどは1,700百万円などと表記することがある
      unit = exception[2] == "千" ? 1000 : 1000000
      return  exception[1].to_i * unit
    end
    partial_arr = []
    TRANSMANS.each do |key , value|
      index = s.index(key.to_s)
      next unless index
      partial_arr << s.slice(0..index-1)
      partial_arr << s[index]
      s = s.slice(index + 1..-1 )
    end
    partial_arr << s unless s.empty?
    filtered_arr = []
    partial_arr.each do |partial|
      unless partial =~ /十|百|千|拾/
        if partial =~ /兆|億|万/
          filtered_arr << filtered_arr.pop * TRANSMANS[partial.to_sym]
        else
          filtered_arr << partial.to_i
        end
        next
      end
      ar = []
      TRANSUNIT.each do |key,value|
        p_index = partial.index(key.to_s)
        next unless p_index
        ar << partial.slice(0..p_index)
        partial = partial.slice(p_index + 1..-1 )
      end
      ar << partial unless partial.empty?
      sum = 0
      ar.each do |wo|
        m_w = wo.match(/([0-9]+)([^0-9]+)/)
        if m_w
          return_num = m_w[1].to_i * TRANSUNIT[m_w[2].to_sym]
        elsif wo.match(/([0-9]+)/)
          return_num = wo.match(/([0-9]+)/)[1].to_i
        else
          return_num = TRANSUNIT[wo.match(/([^0-9]+)/)[1].to_sym]
        end
        sum += return_num
      end
      filtered_arr << sum
    end
    return_num = filtered_arr.inject {|sum, n| sum + n }
    return return_num
  end
end
