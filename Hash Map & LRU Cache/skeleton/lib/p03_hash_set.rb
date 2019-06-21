class HashSet
  attr_reader :store
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      self[key] << key
      self.count += 1
      resize! if self.count > num_buckets
    end 
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      self.count -= 1
    end 
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    prev_buckets = num_buckets
    @store = Array.new(prev_buckets * 2) { Array.new }
    @count = 0
    old_store.flatten.each { |ele| insert(ele) }
  end
end
