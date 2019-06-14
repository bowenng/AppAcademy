require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if @count > num_buckets
      resize!
    end

    if self.include?(key)
      bucket(key).update(key,val)
    else
      bucket(key).append(key, val)
      @count += 1
    end
    
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if self.include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each(&func)
    @store.each do |b|
      b.each do |el|
        func.call(el.key, el.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = 2 * num_buckets
    new_buckets = Array.new(new_num_buckets) {LinkedList.new}
    self.each do |k, v|
      new_buckets[k.hash % new_num_buckets].append(k, v)
    end
    @store = new_buckets
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
