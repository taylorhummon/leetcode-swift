/*
See https://leetcode.com/problems/longest-substring-without-repeating-characters/

3. Longest Substring Without Repeating Characters

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
Use two indices and a set of previously seen characters. Ideally we could use a data structure that
was a FIFO queue and had fast element containment lookups. But we'll settle for a set, and manually
manage the FIFO queue part.

Idea 2
Use two indices and a dictionary of previously seen characters that tracks indices.
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

        // characters will hold the characters from index left to index right, inclusive
        var characters = Set<Character>()
        for right in string.indices {
            let current: Character = string[right]

            // If we've already seen the current character remove all characters up to and
            // including the previous instance of current.
            while characters.contains(current) {
                characters.remove(string[left])
                string.formIndex(after: &left)
            }

            // Insert current into the set of characters
            characters.insert(current)

            // See if we have a new longest length of characters
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
            let current: Character = string[right]

            // Check if we've already seen the current character
            if let lastIndex = lastIndexByCharacter[current] {

                // Don't jump back to consider characters before index left
                if lastIndex >= left {

                    // Make the new left index point immediately after the last place we saw the current character.
                    left = string.index(after: lastIndex)
                }
            }

            // See if we have a new longest length of characters
            // We need to add one because we're considering charactetrs from left to right, inclusive.
            longestLength = max(longestLength, string.distance(from: left, to: right) + 1)

            // Store the index of the current character
            lastIndexByCharacter[current] = right
        }
        return longestLength
    }
}
