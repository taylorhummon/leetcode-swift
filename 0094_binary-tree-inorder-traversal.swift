/*
94. Binary Tree Inorder Traversal

Given the root of a binary tree, return the inorder traversal of its nodes' values.

Example 1:
    Input: root = [1,null,2,3]
    Output: [1,3,2]

Example 2:
    Input: root = [1,2,3,4,5,null,8,null,null,6,7,9]
    Output: [4,2,6,5,7,1,3,9,8]

Example 3:
    Input: root = []
    Output: []

Example 4:
    Input: root = [1]
    Output: [1]

Constraints:
    The number of nodes in the tree is in the range [0, 100].
    -100 <= Node.val <= 100
*/

/*
Idea 1
Recursion.

Idea 2
Iterative using a stack.
*/

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */

class Solution {
    // Leetcode named this. I'd prefer depthFirstValues().
    func inorderTraversal(
        _ root: TreeNode?
    ) -> [Int] {
        return solution2(root)
    }

    func solution1(
        _ root: TreeNode?
    ) -> [Int] {
        guard let node = root else {
            return []
        }
        return solution1(node.left) + [node.val] + solution1(node.right)
    }

    func solution2(
        _ root: TreeNode?
    ) -> [Int] {
        var result = [Int]()
        var stack = [TreeNode]()
        var node = root
        while true {
            addLeftsToStack(&stack, node)
            node = backtrack(&stack, &result)
            if node == nil {
                return result
            }
        }
    }

    func addLeftsToStack(
        _ stack: inout [TreeNode],
        _ tree: TreeNode?
    ) -> Void {
        var tree = tree
        while let node = tree {
            stack.append(node)
            tree = node.left
        }
    }

    func backtrack(
        _ stack: inout [TreeNode],
        _ result: inout [Int]
    ) -> TreeNode? {
        while true {
            if stack.isEmpty {
                return nil
            }
            if let node = stack.popLast() {
                result.append(node.val)
                if node.right != nil {
                    return node.right
                }
            }
            else {
                return nil
            }
        }
    }
}
