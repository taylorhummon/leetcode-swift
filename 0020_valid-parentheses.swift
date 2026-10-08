/*
See https://leetcode.com/problems/valid-parentheses/

20. Valid Parentheses

Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the
input string is valid.

An input string is valid if:
    Open brackets must be closed by the same type of brackets.
    Open brackets must be closed in the correct order.
    Every close bracket has a corresponding open bracket of the same type.

Example 1:
    Input: s = "()"
    Output: true

Example 2:
    Input: s = "()[]{}"
    Output: true

Example 3:
    Input: s = "(]"
    Output: false

Example 4:
    Input: s = "([])"
    Output: true

Example 5:
    Input: s = "([)]"
    Output: false

Constraints:
    1 <= s.length <= 104
    s consists of parentheses only '()[]{}'.
*/

class Solution {
    func isValid(
        _ string: String
    ) -> Bool {
        let openByClosed: [Character: Character] = [
            ")": "(",
            "]": "[",
            "}": "{",
        ]
        let opens: Set<Character> = Set(openByClosed.values)
        var stack = [Character]()
        for character in string {
            if opens.contains(character) {
                stack.append(character)
                continue
            }
            if let open = openByClosed[character] {
                // If we don't have the correct bracket to close, we're sunk
                if stack.isEmpty || stack.popLast() != open {
                    return false
                }
                continue
            }

            // Found an unknown character
            return false
        }

        // Make sure we've matched all open parens
        return stack.isEmpty
    }
}
