/*
See https://leetcode.com/problems/remove-nth-node-from-end-of-list/

19. Remove Nth Node From End of List

Given the head of a linked list, remove the nth node from the end of the list and return its head.

Example 1:
    Input: head = [1,2,3,4,5], n = 2
    Output: [1,2,3,5]

Example 2:
    Input: head = [1], n = 1
    Output: []

Example 3:
    Input: head = [1,2], n = 1
    Output: [1]


Constraints:
    The number of nodes in the list is sz.
    1 <= sz <= 30
    0 <= Node.val <= 100
    1 <= n <= sz
*/

/*
Idea
Advance two pointers in parallel, with one traveling n positions behind the first.

5 -> 4 -> 3 -> 2 -> 1 -> nil
          |    |    |
        left       right

In order to remove the node at position 2, we need a pointer at position 3.
We'll make position 3 point to position 1, removing position 2 from the list.

    left.next = left.next.next

This will work as long as left.next exists as a ListNode. It's OK if left.next.next is nil.
So this only makes sense for n >= 1.
*/

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */

class Solution {
    func removeNthFromEnd(
        _ head: ListNode?,
        _ n: Int
    ) -> ListNode? {
        guard n >= 1 else {
            return nil
        }
        let beforeHead = ListNode(0, head)
        var left: ListNode? = beforeHead
        var right: ListNode? = beforeHead

        // Advance right n times
        for _ in 0 ..< n {
            guard let unwrapped = right else {
                return nil
            }
            right = unwrapped.next
        }

        // Advance left and right until right is on the last non-nil element
        while right?.next != nil {
            right = right!.next
            left = left!.next
        }

        // Excise the node at left.next
        left!.next = left!.next!.next

        return beforeHead.next
    }
}
