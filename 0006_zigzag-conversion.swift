/*
See https://leetcode.com/problems/zigzag-conversion/

6. Zigzag Conversion

The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this:
    P   A   H   N
    A P L S I I G
    Y   I   R
And then read line by line: "PAHNAPLSIIGYIR"

Write the code that will take a string and make this conversion given a number of rows.

Example 1:
    Input: s = "PAYPALISHIRING", numRows = 3
    Output: "PAHNAPLSIIGYIR"

Example 2:
    Input: s = "PAYPALISHIRING", numRows = 4
    Output: "PINALSIGYAHRPI"
    Explanation:
        P     I    N
        A   L S  I G
        Y A   H R
        P     I

Example 3:
    Input: s = "A", numRows = 1
    Output: "A"

Constraints:
    1 <= s.length <= 1000
    s consists of English letters (lower-case and upper-case), ',' and '.'.
    1 <= numRows <= 1000
*/

class Solution {
    func convert(
        _ string: String,
        _ rowsCount: Int
    ) -> String {
        if rowsCount == 1 {
            return string
        }
        let characters = Array(string)
        let n = characters.count
        var result = [String]()
        for i in stride(from: 0, to: n, by: 2 * (rowsCount - 1)) {
            result.append(String(characters[i]))
        }
        for j in 1 ... rowsCount - 2 {
            var i = 0
            while true {
                let k1 = i * 2 * (rowsCount - 1) + j
                if k1 >= n {
                    break
                }
                result.append(String(characters[k1]))
                let k2 = (i + 1) * 2 * (rowsCount - 1) - j
                if k2 >= n {
                    break
                }
                result.append(String(characters[k2]))
                i += 1
            }
        }
        for i in stride(from: rowsCount - 1, to: n, by: 2 * (rowsCount - 1)) {
            result.append(String(characters[i]))
        }
        return result.joined()
    }
}

/*
For rowsCount == 3, the first row consists of letters with indices
  0, 4, 8, 12.

For rowsCount == 4, the first row consists of letters with indices
  0, 6, 12.

These are 0 working modulo 2 * (rowsCount - 1).



For rowsCount == 3, the last row consists of letters with indices
  2, 6, 10.

For rowsCount == 4, the last row consists of letters with indices
  3, 9.

These are rowsCount - 1 working modulo 2 * (rowsCount - 1).



For rowsCount == 3, the middle row consists of letters with indices
  1, 3, 5, 7, 9, 11.

These are 1 working modulo 2.
Equivalently, these are +- 1 modulo 4.



For rowsCount == 4, the middle two rows consist of letters with indices
  1, 5, 7, 11, 13
and
  2, 4, 8, 10.

These are +- 1 modulo 6.
and +- 2 modulo 6.
*/
