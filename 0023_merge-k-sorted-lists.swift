/*
See https://leetcode.com/problems/merge-k-sorted-lists/

23. Merge k Sorted Lists

You are given an array of k linked-lists lists, each linked-list is sorted in ascending order.

Merge all the linked-lists into one sorted linked-list and return it.

Example 1:
    Input: lists = [[1,4,5],[1,3,4],[2,6]]
    Output: [1,1,2,3,4,4,5,6]
    Explanation: The linked-lists are:
    [
      1->4->5,
      1->3->4,
      2->6
    ]
    merging them into one sorted linked list:
    1->1->2->3->4->4->5->6

Example 2:
    Input: lists = []
    Output: []

Example 3:
    Input: lists = [[]]
    Output: []

Constraints:
    k == lists.length
    0 <= k <= 104
    0 <= lists[i].length <= 500
    -10**4 <= lists[i][j] <= 10**4
    lists[i] is sorted in ascending order.
    The sum of lists[i].length will not exceed 10**4.
*/

/*
Idea 1
1. Remove any empty linked lists.
2. Look at the head of each list and find one with a smallest value.
3. Stick that node on to a result linked list.
4. If reducing one of the linked lists made it empty, remove it from consideration.
5. Repeat from step 2.

If we want to cut down on the number of checks for the minimum, we could store the
heads of the linked lists in a sorted way.
A priority queue is probably ideal.
Maybe a simpler way is to store the heads of the linked list sorted by descending
node value. That way it's cheap to pop one off. Inserting is linear time expensive.

Idea 2
Repeatedly merge pairs of lists until there's only one left.
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
    func mergeKLists(
        _ lists: [ListNode?]
    ) -> ListNode? {
        if lists.isEmpty {
            return nil
        }

        let dummy = ListNode()
        var latest = dummy

        var lists: [ListNode] = lists.compactMap { $0 }
        // TODO: Instead of using a sorted list, use a min priority queue.
        // The costly thing is the lists.insert() statements which are O(n).
        lists.sort(using: KeyPathComparator(\.val, order: .reverse))
        while !lists.isEmpty {
            // The following should always succeed because lists is non-empty
            let list = lists.popLast()!

            // Create a list node
            let listNode = ListNode(list.val)
            // Store the new list node
            latest.next = listNode
            // Advance latest to point at the new list node
            latest = listNode

            guard let shorterList = list.next else {
                continue
            }
            // Put shorterList back in lists in sorted position.
            if lists.isEmpty {
                lists.append(shorterList)
            } else if shorterList.val >= lists[0].val {
                lists.insert(shorterList, at: 0)
            } else if shorterList.val <= lists[lists.count - 1].val {
                lists.append(shorterList)
            } else { // We're now finally in a position to use bisect search!
                let target = shorterList.val
                var left = 0
                var right = lists.count - 1
                while left + 1 < right {
                    let middle = (left + right) / 2
                    if lists[middle].val <= target {
                        right = middle
                    } else {
                        left = middle
                    }
                }
                if lists[left].val == target {
                    lists.insert(shorterList, at: left)
                } else {
                    lists.insert(shorterList, at: right)
                }
            }
        }
        return dummy.next
    }
}
