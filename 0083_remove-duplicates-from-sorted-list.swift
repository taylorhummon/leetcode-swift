/*
83. Remove Duplicates from Sorted List

Given the head of a sorted linked list, delete all duplicates such that each element appears only once. Return the linked list sorted as well.

Example 1:
    Input: head = [1,1,2]
    Output: [1,2]

Example 2:
    Input: head = [1,1,2,3,3]
    Output: [1,2,3]

Constraints:
    The number of nodes in the list is in the range [0, 300].
    -100 <= Node.val <= 100
    The list is guaranteed to be sorted in ascending order.
*/

/*
Idea 1
Recursive. Move one node at a time.

Idea 2
Recursive. Use a while loop to skip long lists of duplicates.

Idea 3
Iterative.
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
    func deleteDuplicates(
        _ head: ListNode?
    ) -> ListNode? {
        return solution3(head)
    }

    func solution1(
        _ head: ListNode?
    ) -> ListNode? {
        guard let head = head else {
            return nil
        }
        guard let next = head.next else {
            return head
        }
        if next.val == head.val {
            return solution1(next)
        } else {
            return ListNode(head.val, solution1(next))
        }
    }

    func solution2(
        _ head: ListNode?
    ) -> ListNode? {
        guard let head = head else {
            return nil
        }
        let value = head.val
        var node: ListNode? = head.next
        while node != nil && node!.val == value {
            node = node!.next
        }
        return ListNode(value, solution2(node))
    }

    func solution3(
        _ head: ListNode?
    ) -> ListNode? {
        let dummy = ListNode(0, nil)
        var lastWrittenNode: ListNode = dummy
        var readNode = head
        while readNode != nil {
            let value = readNode!.val
            lastWrittenNode.next = ListNode(value, nil)
            lastWrittenNode = lastWrittenNode.next!
            while readNode != nil && readNode!.val == value {
                readNode = readNode!.next
            }
        }
        return dummy.next
    }
}
