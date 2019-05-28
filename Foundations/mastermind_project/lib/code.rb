class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(pegs)
    pegs.each {|peg| return false if !(POSSIBLE_PEGS.keys.map(&:upcase).include? peg.upcase)}
    return true
  end

  attr_reader :pegs
  def initialize(pegs)
    if self.class.valid_pegs?(pegs)
      @pegs = pegs.map(&:upcase)
    else
      raise "Invalid pegs"
    end
  end

  def self.random(len)
    rand_pegs = Array.new(len) {POSSIBLE_PEGS.keys.sample}
    Code.new(rand_pegs)
  end

  def self.from_string(pegs_string)
    return Code.new(pegs_string.chars)
  end

  def [](index)
    @pegs[index]
  end

  def length
    return @pegs.length
  end

  def num_exact_matches(code)
        num_correct = 0
        @pegs.each_with_index {|peg, i| num_correct += 1 if code[i] == peg}
        return num_correct
  end

  def num_near_matches(code)
     num_correct = 0
     (0...code.length).each do |i| 
      if ((code[i] != @pegs[i]) && (@pegs.include? code[i])) 
        num_correct += 1 
     end
    end
     return num_correct
  end

  def ==(code)
      if code.length != self.length
        return false
      end

      (0..self.length).each {|i| return false if code[i] != self[i]}
      return true
  end
end
