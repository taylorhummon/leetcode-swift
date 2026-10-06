/*
See https://leetcode.com/problems/generate-parentheses/

22. Generate Parentheses

Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

Example 1:
    Input: n = 3
    Output: ["((()))","(()())","(())()","()(())","()()()"]

Example 2:
    Input: n = 1
    Output: ["()"]

Constraints:
    1 <= n <= 8
*/

class Solution {
    func generateParenthesis(
        _ n: Int
    ) -> [String] {
        return generateWith(n, n)
    }

    func generateWith(
        _ remainingOpen: Int,
        _ remainingClosed: Int
    ) -> [String] {
        if remainingOpen == 0 {
            return [""]
        } else if remainingClosed == 0 {
            return generateAppendingOpenParen(remainingOpen, remainingClosed)
        } else if remainingOpen == remainingClosed {
            return generateAppendingClosedParen(remainingOpen, remainingClosed)
        } else {
            return (
                generateAppendingClosedParen(remainingOpen, remainingClosed) +
                generateAppendingOpenParen(remainingOpen, remainingClosed)
            )
        }
    }

    func generateAppendingClosedParen(
        _ remainingOpen: Int,
        _ remainingClosed: Int
    ) -> [String] {
        return generateWith(remainingOpen, remainingClosed - 1).map { $0 + ")" }
    }

    func generateAppendingOpenParen(
        _ remainingOpen: Int,
        _ remainingClosed: Int
    ) -> [String] {
        return generateWith(remainingOpen - 1, remainingClosed).map { $0 + "(" }
    }
}
