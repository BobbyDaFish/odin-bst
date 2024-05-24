# frozen-string-literal: true

require 'pry-byebug'

# Binary Search Tree creator and methods
class Tree
  attr_accessor :root

  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(@data)
  end

  def build_tree(array, first = 0, last = @data.length - 1)
    return nil if first > last

    mid = ((first + last) / 2)
    root_node = Node.new(array[mid])
    root_node.left_node = build_tree(array, first, mid - 1)
    root_node.right_node = build_tree(array, mid + 1, last)
    root_node
  end

  def insert(item, node = @root)
    if item < node.value && node.left_node.nil?
      node.left_node = Node.new(item)
    elsif item < node.value
      insert(item, node.left_node)
    elsif node.right_node.nil?
      node.right_node = Node.new(item)
    else
      insert(item, node.right_node)
    end
  end

  def delete(item, node = @root)

  end
end

private

# Individual nodes in tree
class Node
  attr_accessor :value, :left_node, :right_node

  def initialize(mid)
    @value = mid
  end
end

bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
bst.insert(12)
p bst.delete(3)
p bst.root
