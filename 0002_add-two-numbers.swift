/*
See https://leetcode.com/problems/add-two-numbers/

2. Add Two Numbers

You are given two non-empty linked lists representing two non-negative integers. The digits are
stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and
return the sum as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

Example 1:
    Input: l1 = [2,4,3], l2 = [5,6,4]
    Output: [7,0,8]
    Explanation: 342 + 465 = 807.

Example 2:
    Input: l1 = [0], l2 = [0]
    Output: [0]

Example 3:
    Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
    Output: [8,9,9,9,0,0,0,1]

Constraints:
    The number of nodes in each linked list is in the range [1, 100].
    0 <= Node.val <= 9
    It is guaranteed that the list represents a number that does not have leading zeros.
*/

/*
Idea 1
Use a recursive helper function that takes the two lists and a carry parameter.

Idea 2
Work iteratively, building up a result linked list.
This will require us to keep track of both the start of the result list and the
end of the result list. We'll need to mutate the end of the result list whenever
we want to chain on another digit.
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
    func addTwoNumbers(
        _ list1: ListNode?,
        _ list2: ListNode?
    ) -> ListNode? {
        return solution2(list1, list2)
    }

    func solution1(
        _ list1: ListNode?,
        _ list2: ListNode?,
        carried: Int = 0
    ) -> ListNode? {
        let value1 = list1?.val ?? 0
        let value2 = list2?.val ?? 0
        let possiblyTooLarge = value1 + value2 + carried
        let value = possiblyTooLarge >= 10 ? possiblyTooLarge - 10 : possiblyTooLarge
        let carry = possiblyTooLarge >= 10 ? 1 : 0
        if list1 == nil && list2 == nil {
            if carry == 1 {
                return ListNode(value, ListNode(1, nil))
            } else if value > 0 {
                return ListNode(value, nil)
            } else {
                return nil
            }
        }
        return ListNode(value, solution1(list1?.next, list2?.next, carried: carry))
    }

    func solution2(
        _ list1: ListNode?,
        _ list2: ListNode?
    ) -> ListNode? {
        if list1 == nil && list2 == nil {
            return ListNode(0, nil)
        }
        var list1 = list1
        var list2 = list2
        var carry: Int = 0
        // Using this resultHolder helps us DRY the loop.
        // We'll modify resultHolder.next using lastResultNode.
        let resultHolder = ListNode(-1, nil)
        var lastResultNode = resultHolder
        while list1 != nil || list2 != nil || carry != 0 {
            let value1 = list1?.val ?? 0
            let value2 = list2?.val ?? 0
            let possiblyTooLarge = value1 + value2 + carry
            let value = possiblyTooLarge >= 10 ? possiblyTooLarge - 10 : possiblyTooLarge
            carry = possiblyTooLarge >= 10 ? 1 : 0
            let newResultNode = ListNode(value, nil)
            lastResultNode.next = newResultNode
            lastResultNode = newResultNode
            list1 = list1?.next
            list2 = list2?.next
        }
        return resultHolder.next
    }
}
