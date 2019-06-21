class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index do |ele, i|
       result += (ele.hash * i.hash)
    end 
    result
  end
end

class String
  def hash
    result = 0
    self.each_char.with_index do |ele, i|
      if (1..9).to_s.include?(ele) 
        result += ele.to_i.hash
      elsif ("a".."z").to_a.include?(ele.downcase)
        result += ("a".."z").to_a.index(ele.downcase) * i
      else
        result *= -1
      end
    end
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    self.each do |k,v|
      if k.is_a?(Symbol)
        result += 6
      elsif k.is_a?(Integer)
        result += k.hash
      elsif k.is_a?(String)
        result += ("a".."z").to_a.index(k.downcase) 
      else
        result *= -1
      end
    end
    result
  end
end
