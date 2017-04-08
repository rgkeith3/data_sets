require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

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
    @next.prev = @prev
    @prev.next = @next
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new(:head)
    @tail = Link.new(:tail)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current_link = first
    until current_link == @tail
      if current_link.key == key
        return current_link.val
      else
        current_link = current_link.next
      end
    end
    nil
  end

  def include?(key)
    current_link = first
    until current_link == @tail
      if current_link.key == key
        return true
      else
        current_link = current_link.next
      end
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    new_link.prev = last
    last.next = new_link
    @tail.prev = new_link
    new_link.next = @tail
  end

  def update(key, val)
    current_link = first
    until current_link == @tail
      if current_link.key == key
        current_link.val = val
        break
      else
        current_link = current_link.next
      end
    end
    nil
  end

  def remove(key)
    current_link = first
    until current_link == @tail
      if current_link.key == key
        current_link.remove
        break
      else
        current_link = current_link.next
      end
    end
    nil
  end

  def each
    current_link = first
    until current_link == @tail
      yield(current_link) if block_given?
      current_link = current_link.next
    end
    nil
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
