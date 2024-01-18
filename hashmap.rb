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
    if @buckets[value % @buckets.length].head == nil
      @buckets[value % @buckets.length].head = Node.new(key, value)
    else
      tmp = @buckets[value % @buckets.length].head
      until tmp.next == nil
        tmp = tmp.next
      end
      tmp.next = Node.new(key, value)
    end
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

  def remove(key)
    buckets.each do
      |bucket|
      tmp = bucket.head
      tmp_previous = bucket.head
      #binding.pry
      until tmp == nil
        if tmp.string == key && tmp.next != nil
          tmp_previous.next = tmp.next
          tmp = nil
          return '12345' 
        elsif tmp.string == key && tmp.next == nil
          tmp_previous.next = nil
          tmp = nil
          return '67890'
        end
        tmp_previous = tmp
        tmp = tmp.next
        end
      end
      nil
    end

    def length
      length = 0
      buckets.each do
        |bucket|
        tmp = bucket.head
        until tmp == nil
          tmp = tmp.next
          length += 1
        end
    end
    length
  end

  def clear
    buckets.each do
      |bucket|
      bucket.head = nil
    end
    buckets
  end

  def keys
    keys = []
    buckets.each do
      |bucket|
      tmp = bucket.head
      until tmp == nil
      keys.append(tmp.string) if tmp.string != nil
      tmp = tmp.next
      end
    end
    keys
  end

  def values
    values = []
    buckets.each do
      |bucket|
      tmp = bucket.head
      until tmp == nil
      values.append(tmp.hash_code) if tmp.hash_code != nil
      tmp = tmp.next
      end
    end
    values
  end

  def entries
    entries = []
    buckets.each do
      |bucket|
      tmp = bucket.head
      until tmp == nil
      entries.append([tmp.string, tmp.hash_code]) if tmp.hash_code != nil && tmp.string != nil
      tmp = tmp.next
      end
    end
    entries
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
hash_map.set("Yoyoyo", 30004000)
hash_map.set("Oioioi", 30004000)



p hash_map.buckets
p hash_map.length
p hash_map.values
p hash_map.entries