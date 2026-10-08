/*
See https://leetcode.com/problems/container-with-most-water/

11. Container With Most Water

You are given an integer array height of length n. There are n vertical lines drawn such that the
two endpoints of the ith line are (i, 0) and (i, height[i]).

Find two lines that together with the x-axis form a container, such that the container contains the
most water.

Return the maximum amount of water a container can store.

Notice that you may not slant the container.

Constraints:
    n == height.length
    2 <= n <= 10**5
    0 <= height[i] <= 10**4
*/

/*
Idea 1
Brute force:
Look at each pair of indices and compute the area of the rectangle.
Keep track of the max amount of area found.

Idea 2
Use two indices, one which starts at the left and one that starts at the right.
Meet in the middle.
*/

class Solution {
    func maxArea(
        _ heights: [Int]
    ) -> Int {
        return self.solution2(heights)
    }

    func solution1(
        _ heights: [Int]
    ) -> Int {
        var largestKnownArea = 0
        for right in 0 ..< heights.count {
            for left in 0 ..< right {
                let area = (right - left) * min(heights[left], heights[right])
                largestKnownArea = max(largestKnownArea, area)
            }
        }
        return largestKnownArea
    }

    func solution2(
        _ heights: [Int]
    ) -> Int {
        var left = 0
        var right = heights.count - 1
        var largestKnownArea = area(heights, left, right)

        while left < right {
            let leftHeight = heights[left]
            let rightHeight = heights[right]
            if leftHeight <= rightHeight {
                while left < right && heights[left] <= leftHeight {
                    left += 1
                }
            }
            // We want both this "if" statement and the previous "if" statement to execute
            // when leftHeight == rightHeight
            if leftHeight >= rightHeight {
                while left < right && heights[right] <= rightHeight {
                    right -= 1
                }
            }
            largestKnownArea = max(largestKnownArea, area(heights, left, right))
        }
        return largestKnownArea
    }

    func area(
        _ heights: [Int],
        _ left: Int,
        _ right: Int
    ) -> Int {
        return (right - left) * min(heights[left], heights[right])
    }
}
