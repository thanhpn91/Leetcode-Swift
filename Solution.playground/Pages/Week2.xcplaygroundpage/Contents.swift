//: [Previous](@previous)

import Foundation
import CoreGraphics
import UIKit

class Week2 {
//    876. Middle of the Linked List
//    https://leetcode.com/problems/middle-of-the-linked-list/
    func middleNode(_ head: ListNode?) -> ListNode? {
        guard var firstTraverse = head else {return head}
        guard head != nil && head?.next != nil else {return head}
        
        var count: Double = 0
        while firstTraverse.next != nil {
            firstTraverse = firstTraverse.next!
            count = count + 1
        }
        
        let middle: Double = count/2
        middle.rounded()
        
        count = 0
        var secondTraverse = head!
        while secondTraverse.next != nil {
            if count >= middle {
                break
            }
            secondTraverse = secondTraverse.next!
            count = count + 1
        }
        
        return secondTraverse
    }
    
//    844. Backspace String Compare
//    https://leetcode.com/problems/backspace-string-compare/
    func backspaceCompare(_ S: String, _ T: String) -> Bool {
        var i = S.count - 1
        var j = T.count - 1
        var skipS = 0
        var skipT = 0
        
        let sArray = S.compactMap{String($0)}
        let tArray = T.compactMap{String($0)}
        
        while (i >= 0 || j >= 0) {
            while i >= 0 {
                if  sArray[i] == "#" {
                    skipS = skipS + 1
                    i = i - 1
                } else if skipS > 0 {
                    skipS = skipS - 1
                    i = i - 1
                } else {
                    break
                }
            }
            
            while j >= 0 {
                if  tArray[j] == "#" {
                    skipT = skipT + 1
                    j = j - 1
                } else if skipT > 0 {
                    skipT = skipT - 1
                    j = j - 1
                } else {
                    break
                }
            }
            
            // if two actual characters are different
            if i >= 0 && j >= 0 && sArray[i] != tArray[j] {
                return false
            }
            
            if (i >= 0) != (j >= 0) {
                return false
            }
            
            if sArray[i] != tArray[j] {
                return false
            }
            
            
            i = i - 1
            j = j - 1
        }
        return true
    }
    
//    155. Min Stack
//    https://leetcode.com/problems/min-stack/
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
    
//    543. Diameter of Binary Tree
//    https://leetcode.com/problems/diameter-of-binary-tree/
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        func dfs(_ root: TreeNode?, height: inout Int) -> Int {
            if root == nil {
                return 0
            }
            
            let leftHeight = dfs(root?.left, height: &height)
            
            let rightHeight = dfs(root?.right, height: &height)
            
            height = max(height, 1 + leftHeight + rightHeight)
            
            return max(leftHeight, rightHeight)
        }
        
        if root == nil {
            return 0
        }
        
        var height = 1
        dfs(root, height: &height)
        return height - 1
    }
    
//    1046. Last Stone Weight
//    https://leetcode.com/problems/last-stone-weight/
    func lastStoneWeight(_ stones: [Int]) -> Int {
        if stones.count == 0 {return 0}
        if stones.count == 1 {return stones.first ?? 0}
        
        var stack = stones.sorted()
        
        while stack.count > 0 {
            if stack.count == 2 {
                let lastItem = stack.popLast()
                let preItem = stack.popLast()
                let smash = abs(lastItem! - preItem!)
                return smash
            }
            
            let lastItem = stack.popLast()
            let preItem = stack.popLast()
            let smash = abs(lastItem! - preItem!)
            stack.append(smash)
            stack = stack.sorted()
        }
        
        return 0
    }
    
//    525. Contiguous Array
//    https://leetcode.com/problems/contiguous-array/
    func findMaxLength(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        var hash: [Int: [Int]] = [Int: [Int]]()
        var count: Int = 0
        var maxValue: Int = 0
        for i in 0...nums.count - 1 {
            if nums[i] == 0 {
                count = count - 1
            } else {
                count = count + 1
            }
            
            if count == 0 {
                maxValue = max(maxValue, i + 1)
            }
            
            if hash[count] != nil {
                if let firstIndex = hash[count]?.first{
                    maxValue = max(maxValue, abs(i - firstIndex))
                }
                
                hash[count]?.append(i)
            } else {
                hash[count] = [i]
            }
        }
    
        return maxValue
    }
}

let solution = SolutionWeek2()
solution.backspaceCompare("abcd", "bbcd")
solution.findMaxLength([0,1])
solution.findMaxLength([0,0,1,0,0,0,1,1])


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

