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

To cut down on the number of checks for the minimum, we could store the heads of the
linked lists in a min priority queue. Unfortunately, I can't import a min priority
queue data structure in leetcode (and I'd rather not implement one) so, I'm just
going to store linked list heads in a sorted array. This way:
- It's cheap to pop off the list with minimum head.
- It's cheap to decide where to store a list.
Inserting is a little expensive if the number of lists is large.

Idea 2
Repeatedly merge pairs of lists until there's only one left.
Not yet implemented.
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
        return solution1(lists)
    }

    func solution1(
        _ lists: [ListNode?]
    ) -> ListNode? {
        guard !lists.isEmpty else {
            return nil
        }

        let dummy = ListNode()
        var latest = dummy

        // Remove nil lists
        var lists: [ListNode] = lists.compactMap { $0 }

        // Store the lists in descending order by val.
        lists.sort(using: KeyPathComparator(\.val, order: .reverse))
        while !lists.isEmpty {
            // The following always succeeds because lists is non-empty
            let list = lists.popLast()!

            // Create a list node
            let listNode = ListNode(list.val)

            // Store the new list node
            latest.next = listNode

            // Advance latest to point at the new list node
            latest = listNode

            if let shorterList = list.next {
                insertListIntoSortedLists(list: shorterList, sortedLists: &lists)
            }
        }
        return dummy.next
    }

    func insertListIntoSortedLists(
        list: ListNode,
        sortedLists: inout [ListNode]
    ) -> Void {
        if sortedLists.isEmpty {
            sortedLists.append(list)
        }
        // Should the list be inserted at the front of sortedLists?
        else if list.val >= sortedLists[0].val {
            sortedLists.insert(list, at: 0)
        }
        // Should the list be inserted at the back of sortedLists?
        else if list.val <= sortedLists[sortedLists.count - 1].val {
            sortedLists.append(list)
        }
        // Use bisect search to find where to insert list into sortedList.
        else {
            let target = list.val
            var left = 0
            var right = sortedLists.count - 1
            while left + 1 < right {
                let middle = (left + right) / 2
                if sortedLists[middle].val <= target {
                    right = middle
                }
                else {
                    left = middle
                }
            }
            if sortedLists[left].val == target {
                sortedLists.insert(list, at: left)
            }
            else {
                sortedLists.insert(list, at: right)
            }
        }
    }
}
