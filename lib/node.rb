# frozen-string-literal: true

private

# Individual nodes in tree
class Node
  attr_accessor :value, :left_node, :right_node

  def initialize(mid)
    @value = mid
  end
end
