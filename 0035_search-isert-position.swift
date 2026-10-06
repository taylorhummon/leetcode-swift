/*
See https://leetcode.com/problems/search-insert-position/description/

35. Search Insert Position

Given a sorted array of distinct integers and a target value, return the index if the target is
found. If not, return the index where it would be if it were inserted in order.

You must write an algorithm with O(log n) runtime complexity.

Example 1:
    Input: nums = [1,3,5,6], target = 5
    Output: 2

Example 2:
    Input: nums = [1,3,5,6], target = 2
    Output: 1

Example 3:
    Input: nums = [1,3,5,6], target = 7
    Output: 4

Constraints:
    1 <= nums.length <= 10**4
    -10**4 <= nums[i] <= 10**4
    nums contains distinct values sorted in ascending order.
    -10**4 <= target <= 10**4
*/

class Solution {
    func searchInsert(
        _ numbers: [Int],
        _ target: Int
    ) -> Int {
        var left = 0
        var right = numbers.count - 1
        guard target > numbers[left] else {
            return 0
        }
        guard target <= numbers[right] else {
            return numbers.count
        }
        while left + 1 < right {
            let middle = (left + right) / 2
            if numbers[middle] < target {
                left = middle
            } else if numbers[middle] > target {
                right = middle
            } else {
                return middle
            }
        }
        /*
        At this point we know:
            target >= numbers[left]
            target <= numbers[right]
            left == right or left + 1 == right
        */
        if numbers[left] == target {
            return left
        } else {
            return right
        }
    }
}
