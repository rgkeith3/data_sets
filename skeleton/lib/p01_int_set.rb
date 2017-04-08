class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max + 1, false)
  end

  def insert(num)
    @store[num] = true if is_valid?(num)
  end

  def remove(num)
    @store[num] = false if is_valid?(num)
  end

  def include?(num)
    @store[num] if is_valid?(num)
  end

  private

  def is_valid?(num)
    unless num.between?(0, @max)
      raise "Out of bounds"
    end
    true
  end

  # def validate!(num)
  #
  # end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

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
    @store[num % num_buckets]
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
