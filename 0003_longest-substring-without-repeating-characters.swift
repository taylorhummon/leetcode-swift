/*
See https://leetcode.com/problems/longest-substring-without-repeating-characters/

Longest Substring Without Repeating Characters

Given a string s, find the length of the longest substring without duplicate characters.

Example 1:
    Input: s = "abcabcbb"
    Output: 3
    Explanation: The answer is "abc", with the length of 3. Note that "bca" and "cab" are also correct answers.

Example 2:
    Input: s = "bbbbb"
    Output: 1
    Explanation: The answer is "b", with the length of 1.

Example 3:
    Input: s = "pwwkew"
    Output: 3
    Explanation: The answer is "wke", with the length of 3.
    Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.

Constraints:
    0 <= s.length <= 10**5
    s consists of English letters, digits, symbols and spaces.
*/

/*
Idea 1
Use two indices and a set of previously seen characters.

Idea 2
Use two indices and a dictionary of previously seen characters with their indices.
*/

class Solution {
    func lengthOfLongestSubstring(
        _ string: String
    ) -> Int {
        return solution2(string)
    }

    func solution1(
        _ string: String
    ) -> Int {
        guard !string.isEmpty else {
            return 0
        }
        var longestLength = 0
        var left = string.startIndex
        var characters = Set<Character>()
        for right in string.indices {
            let character = string[right]
            while characters.contains(character) {
                characters.remove(string[left])
                string.formIndex(after: &left)
            }
            characters.insert(character)
            longestLength = max(longestLength, characters.count)
        }
        return longestLength
    }

    func solution2(
        _ string: String
    ) -> Int {
        guard !string.isEmpty else {
            return 0
        }
        var longestLength = 0
        var left = string.startIndex
        var lastIndexByCharacter = Dictionary<Character, String.Index>()
        for right in string.indices {
            let character = string[right]
            if let lastIndex = lastIndexByCharacter[character] {
                if lastIndex >= left {
                    left = string.index(after: lastIndex)
                }
            }
            longestLength = max(longestLength, string.distance(from: left, to: right) + 1)
            lastIndexByCharacter[character] = right
        }
        return longestLength
    }
}
