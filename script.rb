# frozen-string-literal: true

require_relative 'lib/binary_search_tree'

bst = Tree.new(Array.new(15) { rand(1..100) })
p bst.balanced?
bst.level_order { |items| p items }
bst.preorder { |items| p items }
bst.postorder { |items| p items }
bst.inorder { |items| p items }
bst.insert(300)
bst.insert(195)
bst.insert(226)
bst.insert(785)
p bst.balanced?
bst.rebalance
p bst.balanced?
bst.level_order { |items| p items }
bst.preorder { |items| p items }
bst.postorder { |items| p items }
bst.inorder { |items| p items }
