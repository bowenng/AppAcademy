class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max, false)
    @capacity = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true
    
  end

  def remove(num)
    validate!(num)
    @store[num] = false
    
  end

  def include?(num)
    validate!(num)
    @store[num]
    
  end

  private

  def is_valid?(num)
    (0 <= num) && (num < @capacity)
  end

  def validate!(num)
    unless is_valid?(num)
      raise "Out of bounds"
    end
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    unless self.include?(num)
      self[num] << num
    end
  end

  def remove(num)
    if self.include?(num)
      @store[num % @num_buckets]  -= [num]
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
    @count = 0
  end

  def insert(num)
    if @count >= @num_buckets
      resize!
    end
    unless self.include?(num)
      @count += 1
      self[num] << num
    end
  end

  def remove(num)
    if self.include?(num)
      @count -= 1
      @store[num % @num_buckets] -= [num]
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @num_buckets] 
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = 2*num_buckets
    new_store = Array.new(new_num_buckets) {Array.new}

    @store.each do |bucket|
      bucket.each do |el|
        new_store[el % new_num_buckets] << el
      end
    end

    @store = new_store
    @num_buckets = new_num_buckets
  
  end
end
