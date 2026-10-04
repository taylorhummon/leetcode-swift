/*
See https://leetcode.com/problems/longest-palindromic-substring/

Longest Palindromic Substring

Given a string s, return the longest palindromic substring in s.

Example 1:
    Input: s = "babad"
    Output: "bab"
    Explanation: "aba" is also a valid answer.

Example 2:
    Input: s = "cbbd"
    Output: "bb"

Constraints:
    1 <= s.length <= 1000
    s consist of only digits and English letters.
*/

/*
Idea

Find all palindromes of length 1
Find all palindromes of length 3
...

Find all palindromes of length 2
Find all palindromes of length 4
...

Each palindrome of length n contains a palindrome of length n - 2 by dropping
the first and last letters.

Pursue even and odd lengths of palindromes separately, and compare results.

There are n = len(str) possible middle positions for palindromes of odd length.
There are n - 1 possible middle positions for palindromes of even length.
*/

class Solution {
    func longestPalindrome(
        _ string: String
    ) -> String {
        let oddPalindrome = getLongestOddLengthPalindrome(string)
        let evenPalindrome = getLongestEvenLengthPalindrome(string)
        if oddPalindrome.count > evenPalindrome.count {
            return oddPalindrome
        } else {
            return evenPalindrome
        }
    }

    func getLongestOddLengthPalindrome(
        _ string: String
    ) -> String {
        let characters = Array<Character>(string)
        var palindromeIndices = Array(0..<characters.count)
        guard !palindromeIndices.isEmpty else {
            return ""
        }
        var longestPalindrome = [Character]()
        var indexDiff = 0
        while !palindromeIndices.isEmpty {
            let from = palindromeIndices[0] - indexDiff
            let to = palindromeIndices[0] + indexDiff + 1
            longestPalindrome = Array(characters[from..<to])
            indexDiff += 1
            for k in (0..<palindromeIndices.count).reversed() {
                let centerIndex = palindromeIndices[k]
                if (
                    centerIndex - indexDiff < 0 ||
                    centerIndex + indexDiff >= characters.count ||
                    characters[centerIndex - indexDiff] != characters[centerIndex + indexDiff]
                ) {
                    palindromeIndices.remove(at: k)
                }
            }
        }
        return longestPalindrome.map { String($0) }.joined()
    }

    func getLongestEvenLengthPalindrome(
        _ string: String
    ) -> String {
        let characters = Array<Character>(string)
        var palindromeIndices = Array(
            (1..<characters.count).filter { characters[$0 - 1] == characters[$0] }
        )
        guard !palindromeIndices.isEmpty else {
            return ""
        }
        var longestPalindrome = [Character]()
        var indexDiff = 0
        while !palindromeIndices.isEmpty {
            let from = palindromeIndices[0] - indexDiff - 1
            let to = palindromeIndices[0] + indexDiff + 1
            longestPalindrome = Array(characters[from..<to])
            indexDiff += 1
            for k in (0..<palindromeIndices.count).reversed() {
                let centerIndex = palindromeIndices[k]
                if (
                    centerIndex - indexDiff - 1 < 0 ||
                    centerIndex + indexDiff >= characters.count ||
                    characters[centerIndex - indexDiff - 1] != characters[centerIndex + indexDiff]
                ) {
                    palindromeIndices.remove(at: k)
                }
            }
        }
        return longestPalindrome.map { String($0) }.joined()
    }
}
