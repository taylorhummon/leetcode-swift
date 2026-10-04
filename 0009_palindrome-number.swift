/*
See https://leetcode.com/problems/palindrome-number/

Palindrome Number

Given an integer x, return true if x is a palindrome, and false otherwise.

Example 1:
    Input: x = 121
    Output: true
    Explanation: 121 reads as 121 from left to right and from right to left.

Example 2:
    Input: x = -121
    Output: false
    Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.

Example 3:
    Input: x = 10
    Output: false
    Explanation: Reads 01 from right to left. Therefore it is not a palindrome.

Constraints:
    -2**31 <= x <= 2**31 - 1
*/

/*
Idea 1
Generate the digits as an array
Check that the first digit matches the last, second matches penultimate, ... up to the middle

Idea 2
Build the reverse number with modulo and integer division without calculating an
array of digits. Then compare the reverse number to the original number.

Idea 3
Convert the number to a string and check whether the string is a palindrome.
*/

class Solution {
    func isPalindrome(
        _ x: Int
    ) -> Bool {
        return solution3(x)
    }

    func solution1(
        _ x: Int
    ) -> Bool {
        guard x >= 0 else {
            return false
        }
        let digits = digits(x)
        for i in 0..<(digits.count / 2) {
            if digits[i] != digits[digits.count - 1 - i] {
                return false
            }
        }
        return true
    }

    // This function is only required to give appropriate results for non-negative integers.
    func digits(
        _ x: Int
    ) -> [Int] {
        guard x > 0 else {
            return [0]
        }
        var x = x
        var digits = [Int]()
        while x > 0 {
            digits.append(x % 10)
            x /= 10
        }
        return digits
    }

    func solution2(
        _ x: Int
    ) -> Bool {
        guard x < 0 else {
            return false
        }
        var n = x
        var reversed = 0
        while n > 0 {
            reversed *= 10
            reversed += n % 10
            n /= 10
        }
        return reversed == x
    }

    func solution3(
        _ x: Int
    ) -> Bool {
        let string = String(x)
        var left = string.startIndex
        var right = string.index(string.endIndex, offsetBy: -1)
        while left < right {
            if string[left] != string[right] {
                return false
            }
            string.formIndex(after: &left)
            string.formIndex(before: &right)
        }
        return true
    }
}
