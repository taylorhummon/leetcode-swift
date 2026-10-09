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

/*
Idea
Recursion working from right-to-left.

Key fact: When building right-to-left we can never have more open parentheses than closed parentheses.
In other words:
    remainingOpen >= remainingClosed
*/

class Solution {
    // Leetcode chose this function name -- I think generateParentheses() would be better.
    func generateParenthesis(
        _ n: Int
    ) -> [String] {
        return generateWith(n, n)
    }

    func generateWith(
        _ remainingOpen: Int,
        _ remainingClosed: Int
    ) -> [String] {
        if remainingOpen == 0 && remainingClosed == 0 {
            return [""]
        }
        else if remainingOpen > 0 && remainingClosed == 0 {
            return generateAppendingOpenParenthesis(remainingOpen, remainingClosed)
        }
        else if remainingOpen == remainingClosed {
            return generateAppendingClosedParenthesis(remainingOpen, remainingClosed)
        }
        else if remainingOpen > remainingClosed {
            return (
                generateAppendingClosedParenthesis(remainingOpen, remainingClosed) +
                generateAppendingOpenParenthesis(remainingOpen, remainingClosed)
            )
        }
        // This case should never happen.
        else {
            return []
        }
    }

    func generateAppendingClosedParenthesis(
        _ remainingOpen: Int,
        _ remainingClosed: Int
    ) -> [String] {
        return generateWith(remainingOpen, remainingClosed - 1).map { $0 + ")" }
    }

    func generateAppendingOpenParenthesis(
        _ remainingOpen: Int,
        _ remainingClosed: Int
    ) -> [String] {
        return generateWith(remainingOpen - 1, remainingClosed).map { $0 + "(" }
    }
}
