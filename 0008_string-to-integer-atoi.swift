/*
See https://leetcode.com/problems/string-to-integer-atoi/

String to Integer (atoi)

Implement the myAtoi(string s) function, which converts a string to a 32-bit signed integer.

The algorithm for myAtoi(string s) is as follows:

Whitespace: Ignore any leading whitespace (" ").
Signedness: Determine the sign by checking if the next character is '-' or '+', assuming positivity if neither present.
Conversion: Read the integer by skipping leading zeros until a non-digit character is encountered or the end of the string is reached. If no digits were read, then the result is 0.
Rounding: If the integer is out of the 32-bit signed integer range [-231, 231 - 1], then round the integer to remain in the range. Specifically, integers less than -231 should be rounded to -231, and integers greater than 231 - 1 should be rounded to 231 - 1.

Return the integer as the final result.

Note:​​​​​​​ You must not use any built-in library function that converts a string to a number (for example, atoi, stoi, Integer.parseInt, int(), parseInt, Number()). Perform the conversion manually.

Constraints:
    0 <= s.length <= 200
    s consists of English letters (lower-case and upper-case), digits (0 - 9), ' ', '+', '-', and '.'.
*/

class Solution {
    let digitByString: [Character: Int32] = [
        "0": 0,
        "1": 1,
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9,
    ]

    func myAtoi(
        _ string: String
    ) -> Int {
        return Int(atoi(string))
    }

    func atoi(
        _ string: String
    ) -> Int32 {
        var characters = Array(string.trimmingCharacters(in: .whitespaces))
        guard !characters.isEmpty else {
            return 0
        }
        var isNegative = false
        if characters[0] == "+" {
            characters.removeFirst()
        } else if characters[0] == "-" {
            characters.removeFirst()
            isNegative = true
        }
        var digits = [Int32]()
        for character in characters {
            guard let digit = digitByString[character] else {
                break
            }
            digits.append(digit)
        }
        if isNegative && digits == [2, 1, 4, 7, 4, 8, 3, 6, 4, 8] {
            return Int32.min
        }
        if isNegative {
            if let positiveResult = fromDigits(digits) {
                return -positiveResult
            } else {
                return Int32.min
            }
        } else {
            if let result = fromDigits(digits) {
                return result
            } else {
                return Int32.max
            }
        }
    }

    func fromDigits(
        _ digits: [Int32]
    ) -> Int32? {
        var result = Int32(0)
        for digit in digits {
            guard result <= Int32.max / 10 else {
                return nil
            }
            result *= 10
            guard result <= Int32.max - digit else {
                return nil
            }
            result += digit
        }
        return result
    }
}
