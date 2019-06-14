class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count >= num_buckets
      resize!
    end
    unless self.include?(key)
      @count += 1
      @store[key.hash % num_buckets] << key
    end
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    if self.include?(key)
      @count -= 1
      @store[key.hash % num_buckets] -= [key]
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    new_store = Array.new(new_num_buckets) {Array.new}
    
    @store.each do |key|
      new_store[key.hash % new_num_buckets] << key
    end

    @store = new_store
  end
end
