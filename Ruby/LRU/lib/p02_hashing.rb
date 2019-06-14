class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    sum = 7
    self.each_with_index do |el,i|
      sum += el.hash * i 
    end
    sum
  end
end

class String
  def hash
    step = 0
    sum = 0
    hash_code = 7
    self.each_char do |char|
      sum += char.ord * step
      step += 1
      if step % 4 == 0
        hash_code += sum
        step = 0
      end
    end
    sum
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    code = 7
    self.keys.each do |key|
      code += key.hash
    end
    code
  end
end
