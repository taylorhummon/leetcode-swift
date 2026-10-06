/*
See https://leetcode.com/problems/two-sum/

1. Two Sum

You are given an array of integers nums and an integer target, return indices of the two numbers
such that they add up to target.

You may assume that each input would have exactly one solution, and you may not use the same
element twice.

You can return the answer in any order.

Example 1:
    Input: nums = [2,7,11,15], target = 9
    Output: [0,1]
    Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

Example 2:
    Input: nums = [3,2,4], target = 6
    Output: [1,2]

Example 3:
    Input: nums = [3,3], target = 6
    Output: [0,1]

Constraints:
    2 <= nums.length <= 10**4
    -10**9 <= nums[i] <= 10**9
    -10**9 <= target <= 10**9
    Only one valid answer exists.
*/

/*
Idea
Let's "invert" the array so that it becomes a dictionary, [Int: Index].
*/

class Solution {
    func twoSum(
        _ numbers: [Int],
        _ target: Int
    ) -> [Int?] { // I'd prefer this to be a tuple type
        var indexByNumber = [Int: Int]()
        for (i, number) in numbers.enumerated() {
            if let j = indexByNumber[target - number] {
                return [j, i]
            }
            indexByNumber[number] = i
        }
        // Ugh, leetcode won't let me throw, so I'll return a pair of nils
        return [nil, nil]
    }
}
