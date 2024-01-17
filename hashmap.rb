require 'pry-byebug'

class HashMap
  attr_accessor :buckets
  def initialize
    @buckets = Array.new(16) {LinkedList.new}
    @load_factor = 0.75
  end

  def hash(string)
    hash_code = 0
    prime_number = 17

    string.each_char { |char| hash_code = prime_number * hash_code + char.ord}
    hash_code
    if @buckets[hash_code % @buckets.length].head == nil
      @buckets[hash_code % @buckets.length].head = Node.new(string, hash_code)
    else #Collision resoloution
      tmp = @buckets[hash_code % @buckets.length].head
      until tmp.next == nil
        tmp = tmp.next
      end
      tmp.next = Node.new(string, hash_code)
    end
  end

  def set(key, value)
    @buckets.each do
      |bucket|
      tmp = bucket
      until tmp.next == nil
      return tmp.hash_code = value if tmp.key == key
      tmp = tmp.next
      end
    end
    @buckets[value % @buckets.length].head = Node.new(key, value)
  end

  def get(key)
    @buckets.each do
      |bucket|
      tmp = bucket.head
      until tmp == nil
        return tmp.hash_code if tmp.string == key
        tmp = tmp.next
      end
    end
    nil
  end

  def key?(key)
    buckets.each do
      |bucket|
      tmp = bucket.head
      until tmp == nil
        return true if tmp.string == key
        tmp = tmp.next
      end
    end
    false
  end

end


class Node
  attr_accessor :string, :hash_code, :next

  def initialize(string, hash_code)
    @string = string
    @hash_code = hash_code
    @next = nil
  end
end

class LinkedList
  attr_accessor :head, :next

  def initialize
    @head = nil
  end
end



hash_map = HashMap.new()
hash_map.hash("Hello")
hash_map.set("Hello", 10002000)
hash_map.set("Bye-bye", 30004000)

p hash_map.buckets


