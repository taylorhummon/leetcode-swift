/*
See https://leetcode.com/problems/longest-palindromic-substring/

5. Longest Palindromic Substring

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

There are n = string.count possible middle positions for palindromes of odd length.
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
        }
        else {
            return evenPalindrome
        }
    }

    func getLongestOddLengthPalindrome(
        _ string: String
    ) -> String {
        let characters = Array<Character>(string)

        // Every character is a palindrome of length one
        var palindromeIndices = Array(0 ..< characters.count)
        guard !palindromeIndices.isEmpty else {
            return ""
        }

        var longestPalindrome = [Character]()
        var indexDiff = 0
        while !palindromeIndices.isEmpty {
            // Pick out the first palindrome of size 2 * indexDiff + 1
            let from = palindromeIndices[0] - indexDiff
            let to = palindromeIndices[0] + indexDiff
            longestPalindrome = Array(characters[from ... to])

            // Increment indexDiff
            indexDiff += 1

            // We're going to be removing elements from palindromeIndices, so count down
            for k in (0 ..< palindromeIndices.count).reversed() {
                // For odd palindromes, centerIndex refers to an index of a character
                let centerIndex = palindromeIndices[k]

                // If centerIndex is no longer a palindrome for this indexDiff, remove it
                if (
                    centerIndex - indexDiff < 0 ||
                    centerIndex + indexDiff >= characters.count ||
                    characters[centerIndex - indexDiff] != characters[centerIndex + indexDiff]
                ) {
                    palindromeIndices.remove(at: k)
                }
            }
        }

        // Return the longest palindrome as a string
        return longestPalindrome.map { String($0) }.joined()
    }

    func getLongestEvenLengthPalindrome(
        _ string: String
    ) -> String {
        let characters = Array<Character>(string)

        // A palindrome of length two consists of a doubled character, e.g. "ff"
        var palindromeIndices = Array(
            (1 ..< characters.count).filter { characters[$0 - 1] == characters[$0] }
        )
        guard !palindromeIndices.isEmpty else {
            return ""
        }

        var longestPalindrome = [Character]()
        var indexDiff = 1
        while !palindromeIndices.isEmpty {
            // Pick out the first palindrome of size 2 * indexDiff
            let from = palindromeIndices[0] - indexDiff
            let to = palindromeIndices[0] + indexDiff
            longestPalindrome = Array(characters[from ..< to])

            // Increment indexDiff
            indexDiff += 1

            // We're going to be removing elements from palindromeIndices, so count down
            for k in (0 ..< palindromeIndices.count).reversed() {
                // For even palindromes, centerIndex refers to a position between characters
                let centerIndex = palindromeIndices[k]

                // If centerIndex is no longer a palindrome for this indexDiff, remove it
                if (
                    centerIndex - indexDiff < 0 ||
                    centerIndex + indexDiff - 1 >= characters.count ||
                    characters[centerIndex - indexDiff] != characters[centerIndex + indexDiff - 1]
                ) {
                    palindromeIndices.remove(at: k)
                }
            }
        }

        // Return the longest palindrome as a string
        return longestPalindrome.map { String($0) }.joined()
    }
}
