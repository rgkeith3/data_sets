require_relative 'p02_hashing'

class HashSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  attr_reader :count
  
  def insert(num)
    self[num] << num
    @count += 1
    resize! if @count > num_buckets
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1 unless @count == 0
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_array = Array.new(2 * num_buckets) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        new_array[el % new_array.length] << el
      end
    end
    @store = new_array
  end
end
