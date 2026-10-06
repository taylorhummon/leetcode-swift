/*
See https://leetcode.com/problems/find-the-index-of-the-first-occurrence-in-a-string/

28. Find the Index of the First Occurrence in a String

Given two strings needle and haystack, return the index of the first occurrence of needle in
haystack, or -1 if needle is not part of haystack.

Example 1:
    Input: haystack = "sadbutsad", needle = "sad"
    Output: 0
    Explanation: "sad" occurs at index 0 and 6.
    The first occurrence is at index 0, so we return 0.

Example 2:
    Input: haystack = "leetcode", needle = "leeto"
    Output: -1
    Explanation: "leeto" did not occur in "leetcode", so we return -1.

Constraints:
    1 <= haystack.length, needle.length <= 10**4
    haystack and needle consist of only lowercase English characters.
*/

/*
Idea 1
Convert the strings to arrays of characters. Then brute force.

Idea 2
Brute force using string indices.
*/

class Solution {
    func strStr(
        _ haystack: String,
        _ needle: String
    ) -> Int {
        return solution1(haystack, needle)
    }

    func solution1(
        _ haystack: String,
        _ needle: String
    ) -> Int {
        let haystackArray = Array(haystack)
        let needleArray = Array(needle)
        let top = max(0, haystackArray.count - needleArray.count + 1)
        for i in 0 ..< top {
            var foundSubstring = true   // Assume true until proven false
            for j in 0 ..< needleArray.count {
                if needleArray[j] != haystackArray[i + j] {
                    foundSubstring = false
                    break
                }
            }
            if foundSubstring {
                return i
            }
        }
        return -1
    }

    func solution2(
        _ haystack: String,
        _ needle: String
    ) -> Int {
        guard haystack.count >= needle.count else {
            return -1
        }
        var i = haystack.startIndex
        while i < haystack.endIndex {
            var foundSubstring = true   // Assume true until proven false
            var j = needle.startIndex
            var k = i
            while j < needle.endIndex {
                if k >= haystack.endIndex || needle[j] != haystack[k] {
                    foundSubstring = false
                    break
                }
                needle.formIndex(after: &j)
                haystack.formIndex(after: &k)
            }
            if foundSubstring {
                return haystack.distance(from: haystack.startIndex, to: i)
            }
            haystack.formIndex(after: &i)
        }
        return -1
    }
}
