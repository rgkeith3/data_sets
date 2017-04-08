class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    coded = self.map.with_index do |el, id|
      case el.class
      when String, Array, Hash
        5 + el.hash ^ id
      when Fixnum
        5 + el ^ id
      end
    end
    coded.join.to_i
  end
end

class String
  def hash
    coded = self.chars
    coded.map!.with_index do |el, id|
      el.ord ^ id
    end
    coded.join.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_array = self.to_a
    hash_array.map! do |arr|
      arr.map! do |el|
        el.to_s.hash
      end
      (3 * arr[0]) ^ arr[1]
    end
    hash_array.sort.join.to_i
  end
end
