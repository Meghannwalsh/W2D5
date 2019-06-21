require "byebug"

class MaxIntSet

  attr_reader :store
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    if is_valid?(num)
      unless include?(num)
        store[num] = true 
      end
    end 
  end

  def remove(num)
    if include?(num)
      store[num] = false
    end
  end

  def include?(num)
    store[num] == true
  end

  private

  def is_valid?(num)
      if num >= @max || num < 0
      raise ("Out of bounds")
      else 
        true 
      end 
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    i = num % num_buckets 
    store[i] << num
  end

  def remove(num)
    i = num % num_buckets 
    store[i].delete(num)
  end

  def include?(num)
    i = num % num_buckets 
    store[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :store
  attr_accessor :count
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)  
      i = num % num_buckets  
      store[i] << num
      self.count += 1
      resize! if self.count > num_buckets
    end
  end

  def remove(num)
    if include?(num)
      i = num % num_buckets 
      store[i].delete(num)
      self.count -= 1
    end
  end

  def include?(num)
    i = num % num_buckets 
    store[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
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
