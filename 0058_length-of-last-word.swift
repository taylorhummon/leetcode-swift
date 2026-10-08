/*
58. Length of Last Word

Given a string s consisting of words and spaces, return the length of the last word in the string.

A word is a maximal substring consisting of non-space characters only.

Example 1:
    Input: s = "Hello World"
    Output: 5
    Explanation: The last word is "World" with length 5.

Example 2:
    Input: s = "   fly me   to   the moon  "
    Output: 4
    Explanation: The last word is "moon" with length 4.

Example 3:
    Input: s = "luffy is still joyboy"
    Output: 6
    Explanation: The last word is "joyboy" with length 6.

Constraints:
    1 <= s.length <= 10 ** 4
    s consists of only English letters and spaces ' '.
    There will be at least one word in s.
*/

/*
Idea 1
Convert the string into an array of characters.
Find the index (i) of the last non-space character.
Find the index (j) of the last space character that comes before the last non-space character.
Subtract: i - j

Idea 2
Use string indices instead of converting the string to an array.
We can't walk off the beginning of the string, so we need to work a little harder.
In particular, if using j finds a space we can just subtract i - j, otherwise we need to add one: i - j + 1.
*/

class Solution {
    func lengthOfLastWord(
        _ string: String
    ) -> Int {
        return solution2(string)
    }

    func solution1(
        _ string: String
    ) -> Int {
        let array = Array(string)
        guard !array.isEmpty else {
            return -1
        }

        var i = string.count - 1
        while i >= 0 && array[i] == " " {
            i -= 1
        }
        var j = i
        while j >= 0 && array[j] != " " {
            j -= 1
        }
        return i - j
    }

    func solution2(
        _ string: String
    ) -> Int {
        guard !string.isEmpty else {
            return -1
        }

        // We can offset by -1 since we've ensured the string is non-empty.
        var i = string.index(string.endIndex, offsetBy: -1)
        // Walk i backwards across spaces, making sure not to walk off the string.
        while i > string.startIndex && string[i] == " " {
            string.formIndex(before: &i)
        }
        // If the string was all spaces, return an absurd value, -1.
        if i == string.startIndex && string[i] == " " {
            return -1
        }

        var j = i
        // Walk j backwards across letters, making sure not to walk off the string.
        while j > string.startIndex && string[j] != " " {
            string.formIndex(before: &j)
        }
        // If we hit a space, return the distance.
        // e.g. "dog says woof" or " meow"
        // If we didn't hit a space, return the distance plus one.
        // e.g. "cat" has i = 2 and j = 0.
        if string[j] == " " {
            return string.distance(from: j, to: i)
        } else {
            return string.distance(from: j, to: i) + 1
        }
    }
}
