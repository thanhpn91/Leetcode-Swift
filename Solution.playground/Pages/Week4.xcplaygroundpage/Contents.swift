
import UIKit
import Foundation

class SolutionWeek4 {
//    560. Subarray Sum Equals K
//    https://leetcode.com/problems/subarray-sum-equals-k/
    func subarraySum(_ arr: [Int], _ k: Int, _ threshold: Int) -> Int {
        var result = 0
        
        var left = 0
        var right = k - 1
        
        var average = 0
        for m in 0...k-1 {
            average = average + arr[m]
        }
        
        if average/k >= threshold {
            result = result + 1
        }
        
        while right < arr.count - 1 {
            average = average - arr[left]
            left = left + 1
            right = right + 1
            average = average + arr[right]
            if average/k >= threshold {
                result = result + 1
            }
        }
        
        return result
    }
    
//    1143. Longest Common Subsequence
//    https://leetcode.com/problems/longest-common-subsequence/
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        func lcs(_ array1: [String], array2: [String], n: Int, m: Int) -> Int{
                        
            var matrix = [[Int]](repeating: [Int](repeating: 0, count: m+1), count: n+1)
            for i in 0...n {
                for j in 0...m {
                    if i == 0 || j == 0 {
                        matrix[i][j] = 0
                    } else if array1[i-1] == array2[j-1] {
                        matrix[i][j] = matrix[i-1][j-1] + 1
                    } else {
                        matrix[i][j] = max(matrix[i][j-1], matrix[i-1][j])
                    }
                }
            }
            
            return matrix[n][m]
        }
        
        let array1 = text1.compactMap{String($0)}
        let array2 = text2.compactMap{String($0)}
        return lcs(array1, array2: array2, n: array1.count, m: array2.count)
    }
    
//    55. Jump Game
//    https://leetcode.com/problems/jump-game/
    func canJump(_ nums: [Int]) -> Bool {
        if nums.count == 0 {
            return false
        }
        
        var lastGoodIndex = 0
        for i in (0...nums.count-1).reversed(){
            if i + nums[i] >= lastGoodIndex {
                lastGoodIndex = i
            }
        }
        
        return lastGoodIndex == 0
    }
    
//    221. Maximal Square
//    https://leetcode.com/problems/maximal-square/
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        if matrix.count == 0 {
            return 0
        }
        
        var copied = Array(repeating: Array(repeating: 0, count: matrix.first?.count ?? 0), count: matrix.count)
        for i in 0...matrix.count-1{
            for j in 0...matrix[i].count-1{
               copied[i][j] = Int(String(matrix[i][j])) ?? 0
            }
        }
        
        for i in 0...matrix.count-1{
            for j in 0...matrix[i].count-1{
                if matrix[i][j] == "1" {
                    var top = 0
                    var left = 0
                    var topLeft = 0
                    
                    if i >= 1 {
                        top = copied[i-1][j]

                    }
                    if j >= 1 {
                        left = copied[i][j-1]

                    }
                    if i >= 1 && j >= 1 {
                        topLeft = copied[i-1][j-1]
                    }
                    
                    copied[i][j] = min(top, left, topLeft) + 1
                }
            }
        }
        
        var maximalSquare = 0
        for i in 0...copied.count-1{
            for j in 0...copied[i].count-1{
                if maximalSquare < copied[i][j] {
                    maximalSquare = copied[i][j]
                }
            }
        }
        
        return maximalSquare * maximalSquare
    }
}

 let solution = SolutionWeek4()
solution.longestCommonSubsequence("pmjghexybyrgzczy", "hafcdqbgncrcbihkd")
solution.canJump([2,3,1,1,4])
solution.subarraySum([1,1,1,1,1], 1, 0)

solution.maximalSquare([["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]])


public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
     }
}

//  Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 }

class MinStack {

    var stack: [Int] = []
    var minStack: [Int] = []
    
    init() {
    }
    
    func push(_ x: Int) {
        stack.append(x)
        if let lastItem = minStack.last {
            if lastItem > x {
                minStack.append(x)
            } else {
                minStack.append(lastItem)
            }
        } else {
            minStack.append(x)
        }
    }
    
    func pop() {
        stack.popLast()
        minStack.popLast()
    }
    
    func top() -> Int {
        return stack.last ?? -1
    }
    
    func getMin() -> Int {
        return minStack.last ?? -1
    }
}
