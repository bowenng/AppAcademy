require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_node!(@map[key])
      return @map[key]
    else
      return calc!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    
    @map[key] = @store.append(key,val)
    if count > @max
      eject!
    end
    return val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.remove(node.key)
    @map[node.key] = @store.append(node.key, node.val)
  end

  def eject!
    first = @store.first
    @store.remove(first.key)
    @map.delete(first.key)
  end
end
