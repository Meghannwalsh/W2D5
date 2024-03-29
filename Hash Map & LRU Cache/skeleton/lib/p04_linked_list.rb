# require "Enumerable"
require "byebug"
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev


  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail && tail.prev == head
  end

  def get(key)
     current_node = head.next
    until current_node == tail
      if current_node.key == key 
        return current_node.val
        break
      end 
      current_node = current_node.next
    end
  end

  def include?(key)
    current_node = head
    until current_node == tail
      return true if current_node.key == key 
      current_node = current_node.next
    end
    false
  end

  def append(key, val)
    unless include?(key)  
      new_node = Node.new(key, val)
      last_node = tail.prev 
      last_node.next = new_node 
      new_node.prev = last_node 
      new_node.next = tail
      tail.prev = new_node  
    end 
  end

  def update(key, val)
    current_node = head.next
    until current_node == tail
      if current_node.key == key 
        current_node.val = val
        break
      end 
      current_node = current_node.next
    end
  end

  def remove(key)
     current_node = head.next
    until current_node == tail
      if current_node.key == key 
        next_node = current_node.next
        prev_node = current_node.prev

        prev_node.next = next_node 
        next_node.prev = prev_node
        break
      end 
      current_node = current_node.next
    end
  end

  def each(&prc)
    arr = []
    current_node = head.next
     until current_node == tail
        arr << prc.call(current_node)
        current_node = current_node.next
     end 
    arr
  end 

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
