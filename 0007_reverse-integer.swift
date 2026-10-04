/*
See https://leetcode.com/problems/reverse-integer/

Reverse Integer

Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value
to go outside the signed 32-bit integer range [-231, 231 - 1], then return 0.

Assume the environment does not allow you to store 64-bit integers (signed or unsigned).

Example 1:
    Input: x = 123
    Output: 321

Example 2:
    Input: x = -123
    Output: -321

Example 3:
    Input: x = 120
    Output: 21

Constraints:
    -2**31 <= x <= 2**31 - 1
*/

/*
Idea 1
Implement toDigits for non-negative numbers.
Implement fromDigits in a way that checks for overflow.
Convert to digits, reverse the digits, convert from digits.

Idea 2
Similar to idea 1, but avoid using a digits array.
*/

class Solution {
    func reverse(
        _ x: Int
    ) -> Int {
        return Int(solution2(Int32(x)))
    }

    func solution1(
        _ x: Int32
    ) -> Int32 {
        if x >= 0 {
            var digits = toDigits(x)
            digits.reverse()
            if let result = fromDigits(digits) {
                return result
            } else {
                return 0
            }
        } else if x == -2147483648 {
            return 0
        } else {
            var digits = toDigits(-x)
            digits.reverse()
            if let result = fromDigits(digits) {
                return -result
            } else {
                return 0
            }
        }
    }

    // We only need toDigits to be correct for x >= 0.
    func toDigits(
        _ x: Int32
    ) -> [Int32] {
        guard x > 0 else {
            return [0]
        }
        var x = x
        var digits = [Int32]()
        while x > 0 {
            digits.append(x % 10)
            x /= 10
        }
        return digits
    }

    func fromDigits(
        _ digits: [Int32]
    ) -> Int32? {
        let topOverTen = Int32.max / 10
        var digits = digits
        var result = Int32(0)
        while !digits.isEmpty {
            guard result <= topOverTen else {
                return nil
            }
            let digit = digits.popLast()!
            result *= 10
            guard result <= Int32.max - digit else {
                return nil
            }
            result += digit
        }
        return result
    }

    func solution2(
        _ x: Int32
    ) -> Int32 {
        if x >= 0 {
            if let result = solution2Helper(x) {
                return result
            } else {
                return 0
            }
        } else if x == -2147483648 {
            return 0
        } else {
            if let result = solution2Helper(-x) {
                return -result
            } else {
                return 0
            }
        }
    }

    // solution2Helper only needs to work for x >= 0
    func solution2Helper(
        _ x: Int32
    ) -> Int32? {
        let topOverTen = Int32.max / 10
        guard x >= 0 else {
            return 0
        }
        var x = x
        var result = Int32(0)
        while x > 0 {
            guard result <= topOverTen else {
                return nil
            }
            let digit = x % 10
            result *= 10
            guard result <= Int32.max - digit else {
                return nil
            }
            result += digit
            x /= 10
        }
        return result
    }
}
