/*
101. Symmetric Tree

Given the root of a binary tree, check whether it is a mirror of itself (i.e., symmetric around
its center).

Example 1:
    Input: root = [1,2,2,3,4,4,3]
    Output: true

Example 2:
    Input: root = [1,2,2,null,3,null,3]
    Output: false

Constraints:
    The number of nodes in the tree is in the range [1, 1000].
    -100 <= Node.val <= 100
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
    func isSymmetric(
        _ root: TreeNode?
    ) -> Bool {
        guard let root = root else {
            return true
        }
        return helper(root.left, root.right)
    }

    func helper(
        _ treeA: TreeNode?,
        _ treeB: TreeNode?
    ) -> Bool {
        if treeA == nil && treeB == nil {
            return true
        }
        guard let treeA = treeA else {
            return false
        }
        guard let treeB = treeB else {
            return false
        }
        if treeA.val != treeB.val {
            return false
        }
        if !helper(treeA.left, treeB.right) {
            return false
        }
        if !helper(treeA.right, treeB.left) {
            return false
        }
        return true
    }
}
