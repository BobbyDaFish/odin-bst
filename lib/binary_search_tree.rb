# frozen-string-literal: true

require_relative 'node'
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

    mid = (first + last) / 2
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
    return node if node.nil?

    if item < node.value
      node.left_node = delete(item, node.left_node)
    elsif item > node.value
      node.right_node = delete(item, node.right_node)
    else
      # node with only one child or no child
      if node.left_node.nil?
        temp = node.right_node
        node = nil
        return temp
      elsif node.right_node.nil?
        temp = node.left_node
        node = nil
        return temp
      end

      # node with two children: get the inorder successor (smallest in the right subtree)
      temp = min_value_node(node.right_children)

      # copy the inorder successor's content to this node
      node.data = temp.data

      # delete the inorder successor
      node.right_children = delete(temp.data, node.right_children)
    end
    node
  end

  def min_value(node)
    min = node.value
    until node.left_node.nil?
      min = node.left_node.value
      node = node.left_node
    end
    min
  end

  def find(value, node = @root)
    return nil if node.nil?
    return node if node.value == value

    if value < node.value
      find(value, node.left_node)
    else
      find(value, node.right_node)
    end
  end

  def level_order(node = @root)
    queue = [node.value]
    i = 0
    until queue.length == get_preorder(node).length
      next_node = find(queue[i])
      queue << next_node.left_node.value unless next_node.left_node.nil?
      queue << next_node.right_node.value unless next_node.right_node.nil?
      i += 1
    end
    yield queue
  end

  def get_preorder(node = @root, queue = []) # root, then left, then right
    queue << node.value
    queue = get_preorder(node.left_node, queue) unless node.left_node.nil?
    queue = get_preorder(node.right_node, queue) unless node.right_node.nil?

    queue
  end

  def get_inorder(node = @root, queue = []) # root, then left, then right
    queue = get_inorder(node.left_node, queue) unless node.left_node.nil?

    queue << node.value
    queue = get_inorder(node.right_node, queue) unless node.right_node.nil?

    queue
  end

  def get_postorder(node = @root, queue = []) # root, then left, then right
    queue = get_postorder(node.left_node, queue) unless node.left_node.nil?
    queue = get_postorder(node.right_node, queue) unless node.right_node.nil?

    queue << node.value
    queue
  end

  def preorder
    yield get_preorder
  end

  def postorder
    yield get_postorder
  end

  def inorder
    yield get_inorder
  end

  def find_bottom(value)
    node = find(value)
    level_order(node) { |items| items[-1] }
  end

  def height(value, node = find(value), i = 0)
    return nil if node.nil?

    bottom = find_bottom(value)
    return i if node.value == bottom

    i += 1
    if bottom < node.value
      height(value, node.left_node, i)
    else
      height(value, node.right_node, i)
    end
  end

  def depth(value, node = @root, i = 0)
    nil if find(value).nil?
    return i if node.value == value

    i += 1
    if value < node.value
      height(value, node.left_node, i)
    else
      height(value, node.right_node, i)
    end
  end

  def balanced?(node = @root)
    l_height = height(node.left_node.value, node.left_node)
    r_height = height(node.right_node.value, node.right_node)
    if (l_height - r_height) <= 1 && (l_height - r_height) >= -1
      true
    else
      false
    end
  end

  def rebalance
    @data = level_order { |items| items }.sort.uniq
    @root = build_tree(@data)
  end
end
