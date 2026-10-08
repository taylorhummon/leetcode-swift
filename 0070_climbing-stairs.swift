/*
70. Climbing Stairs

You are climbing a staircase. It takes n steps to reach the top.

Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

Example 1:
    Input: n = 2
    Output: 2
    Explanation: There are two ways to climb to the top.
    1. 1 step + 1 step
    2. 2 steps

Example 2:
    Input: n = 3
    Output: 3
    Explanation: There are three ways to climb to the top.
    1. 1 step + 1 step + 1 step
    2. 1 step + 2 steps
    3. 2 steps + 1 step

Constraints:
    1 <= n <= 45
*/

/*
Idea
To calculate, n = 5, we just need to know values for n = 4 and n = 3. In fact,
we'll just add the n = 4 and n = 3 values. This is just Fibonacci! Let's generate
solutions from the bottom up.
*/

class Solution {
    func climbStairs(
        _ n: Int
    ) -> Int {
        guard n >= 0 else {
            return -1
        }
        if n == 0 {
            return 1
        }
        var previous = 1    // n = 0
        var current = 1     // n = 1
        for k in 1 ..< n {
            let next = previous + current
            previous = current
            current = next
        }
        return current
    }
}
