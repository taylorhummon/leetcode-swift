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
Idea 1
Keep track of a set of seen integers.

Idea 2
Instead of using a set, use a dictionary that keeps track of where in the array a number was seen.
*/

class Solution {
    func twoSum(
        _ numbers: [Int],
        _ target: Int
    ) -> [Int?] {
        let (number1, number2) = solution2(numbers, target)
        // Leetcode wants its answer as an array, not a tuple
        return [number1, number2]
    }

    func solution1(
        _ numbers: [Int],
        _ target: Int
    ) -> (Int, Int) {
        var seen = Set<Int>()
        for number in numbers {
            // We'll check if we've seen an integer, complement, satisfying:
            //   number + compliment = target
            let compliment = target - number
            if seen.contains(compliment) {
                return (
                    // We'll use firstIndex and lastIndex so that we get different indices in the case that number = compliment.
                    numbers.firstIndex(of: number)!,
                    numbers.lastIndex(of: compliment)!
                )
            }
            seen.insert(number)
        }
        return (-1, -1)
    }

    func solution2(
        _ numbers: [Int],
        _ target: Int
    ) -> (Int, Int) {
        var indexByNumber = [Int: Int]()
        for (i, number) in numbers.enumerated() {
            if let j = indexByNumber[target - number] {
                return (i, j)
            }
            indexByNumber[number] = i
        }
        return (-1, -1)
    }
}
