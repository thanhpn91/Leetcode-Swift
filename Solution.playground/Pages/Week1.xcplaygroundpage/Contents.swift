//: [Previous](@previous)

import Foundation

import UIKit

class Week1 {
//    49. Group Anagrams
//    https://leetcode.com/problems/group-anagrams/
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var anagramsMap = [[String]: [String]]()
        
        strs.forEach { (str) in
            var strComponent = str.map{String($0)}
            strComponent.sort()
            if anagramsMap[strComponent] == nil {
                anagramsMap[strComponent] = [str]
            } else {
                anagramsMap[strComponent]?.append(str)
            }
        }
        
        var result = [[String]]()
        
        anagramsMap.forEach { (key, values) in
            result.append(values)
        }
                
        return result
    }
    
    // 53. Maximum Subarray
    // https://leetcode.com/problems/maximum-subarray/
    func maxSubArray(_ nums: [Int]) -> Int {
        var maxValue = 0
        var currentValue = 0
        for i in 0...nums.count - 2 {
            for j in i...nums.count - 1 {
                currentValue = currentValue + nums[j]
                if currentValue > maxValue {
                    maxValue = currentValue
                }
            }
        }
       
        return maxValue
   }
    
//    122. Best Time to Buy and Sell Stock II
//    https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 1 else {
            return 0
        }
        
        var profit = 0
        for i in 1...prices.count - 1 {
            let dayProfit = prices[i] - prices[i-1]
            if dayProfit > 0 {
                profit = profit + dayProfit
            }
        }
        
        return profit
    }
    
    // 136. Single Number
    // https://leetcode.com/problems/single-number/
    func singleNumber(_ nums: [Int]) -> Int {
        var histogramMap: [Int:Int] = [:]
        nums.forEach { (num) in
            histogramMap[num] = (histogramMap[num] ?? 0) + 1
        }
        
        var result = 0
        
        histogramMap.forEach { (key, count) in
            if count == 1 {
                result = key
                return
            }
        }
        
        return result
    }
    
    // 202. Happy Number
    // https://leetcode.com/problems/happy-number/
    func isHappy(_ n: Int) -> Bool {
        func nextComputedInt(_ int: Int) -> Int {
            
            let str = String(int)
            let components = str.map{Int(String($0))!}
            
            var result = 0
            components.forEach { (num) in
                result = result + num*num
            }
            return result
        }
        
        var setI = Set<Int>()
        var sum = n
        while sum != 1{
            if setI.contains(sum) {
                return false
            }
            setI.insert(sum)
            sum = nextComputedInt(sum)
        }
        return true
    }
    
//    283. Move ZeroesMove Zeroes
//    https://leetcode.com/problems/move-zeroes/
    func moveZeroes(_ nums: inout [Int]) {
        var result = nums.filter{$0 != 0}
        var countZero = nums.count - result.count
        
        while countZero > 0 {
            result.append(0)
            countZero = countZero - 1
        }
        
        nums = result
    }
}


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
