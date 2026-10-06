/*
See https://leetcode.com/problems/merge-two-sorted-lists/

21. Merge Two Sorted Lists

You are given the heads of two sorted linked lists list1 and list2.

Merge the two lists into one sorted list. The list should be made by splicing together the nodes of
the first two lists.

Return the head of the merged linked list.

Example 1:
    Input: list1 = [1,2,4], list2 = [1,3,4]
    Output: [1,1,2,3,4,4]

Example 2:
    Input: list1 = [], list2 = []
    Output: []

Example 3:
    Input: list1 = [], list2 = [0]
    Output: [0]

Constraints:
    The number of nodes in both lists is in the range [0, 50].
    -100 <= Node.val <= 100
    Both list1 and list2 are sorted in non-decreasing order.
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
    func mergeTwoLists(
        _ list1: ListNode?,
        _ list2: ListNode?
    ) -> ListNode? {
        return solution2(list1, list2)
    }

    func solution1(
        _ list1: ListNode?,
        _ list2: ListNode?
    ) -> ListNode? {
        guard let list1 = list1 else {
            return list2
        }
        guard let list2 = list2 else {
            return list1
        }
        if list1.val <= list2.val {
            list1.next = solution1(list1.next, list2)
            return list1
        } else {
            list2.next = solution1(list1, list2.next)
            return list2
        }
    }

    func solution2(
        _ list1: ListNode?,
        _ list2: ListNode?
    ) -> ListNode? {
        guard let list1 = list1 else {
            return list2
        }
        guard let list2 = list2 else {
            return list1
        }

        let resultFirst: ListNode
        var resultLast: ListNode
        var remaining1: ListNode?
        var remaining2: ListNode?
        if list1.val <= list2.val {
            resultFirst = list1
            resultLast = list1
            remaining1 = list1.next
            remaining2 = list2
        } else {
            resultFirst = list2
            resultLast = list2
            remaining1 = list1
            remaining2 = list2.next
        }

        while remaining1 != nil || remaining2 != nil {
            guard let node1 = remaining1 else {
                resultLast.next = remaining2
                break
            }
            guard let node2 = remaining2 else {
                resultLast.next = remaining1
                break
            }

            if node1.val <= node2.val {
                remaining1 = node1.next
                // Advance resultLast to be node1
                resultLast.next = node1
                resultLast = node1
                resultLast.next = nil
            } else {
                remaining2 = node2.next
                // Advance resultLast to be node2
                resultLast.next = node2
                resultLast = node2
                resultLast.next = nil
            }
        }
        return resultFirst
    }
}
