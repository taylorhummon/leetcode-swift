/*
100. Same Tree

Given the roots of two binary trees p and q, write a function to check if they are the same or not.

Two binary trees are considered the same if they are structurally identical, and the nodes have the
same value.

Example 1:
    Input: p = [1,2,3], q = [1,2,3]
    Output: true

Example 2:
    Input: p = [1,2], q = [1,null,2]
    Output: false

Example 3:
    Input: p = [1,2,1], q = [1,1,2]
    Output: false

Constraints:
    The number of nodes in both trees is in the range [0, 100].
    -10**4 <= Node.val <= 10**4
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
    func isSameTree(
        _ p: TreeNode?,
        _ q: TreeNode?
    ) -> Bool {
        if p == nil && q == nil {
            return true
        }
        if p == nil || q == nil {
            return false
        }
        // We can unwrap p and q because we just ensured they're not nil.
        let p = p!
        let q = q!
        if p.val != q.val {
            return false
        }
        if !isSameTree(p.left, q.left) {
            return false
        }
        if !isSameTree(p.right, q.right) {
            return false
        }
        return true
    }
}
