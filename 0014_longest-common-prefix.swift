/*
See https://leetcode.com/problems/longest-common-prefix/

14. Longest Common Prefix

Write a function to find the longest common prefix string amongst an array of strings.

If there is no common prefix, return an empty string "".

Example 1:
    Input: strs = ["flower","flow","flight"]
    Output: "fl"

Example 2:
    Input: strs = ["dog","racecar","car"]
    Output: ""
    Explanation: There is no common prefix among the input strings.

Constraints:
    1 <= strs.length <= 200
    0 <= strs[i].length <= 200
    strs[i] consists of only lowercase English letters if it is non-empty.
*/

/*
Idea
Find the smallest and largest strings according to lexicographic ordering.
Step through the two strings until you find a character that's different or reach the end of one of the strings.
*/

class Solution {
    func longestCommonPrefix(
        _ strings: [String]
    ) -> String {
        guard !strings.isEmpty else {
            return ""
        }
        let stringA = strings.min()!
        let stringB = strings.max()!
        let endIndex = min(stringA.endIndex, stringB.endIndex)
        var indexA = stringA.startIndex
        var indexB = stringB.startIndex
        while indexA < endIndex && stringA[indexA] == stringB[indexB] {
            stringA.formIndex(after: &indexA)
            stringB.formIndex(after: &indexB)
        }
        return String(stringA[stringA.startIndex ..< indexA])
    }
}
