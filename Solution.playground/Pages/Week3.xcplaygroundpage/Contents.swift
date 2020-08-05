//: [Previous](@previous)

import Foundation

class Solution3 {
    
//    238. Product of Array Except Self
//    https://leetcode.com/problems/product-of-array-except-self/
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var leftSum = Array(repeating: 1, count: nums.count)
        var rightSum = Array(repeating: 1, count: nums.count)
        var result = Array(repeating: 1, count: nums.count)
        
        var left = 1
        for i in 0...nums.count - 1 {
            leftSum[i] = left
            left = left * nums[i]
        }
                
        var right = 1
        for i in (0...nums.count - 1).reversed() {
            rightSum[i] = right
            right = right * nums[i]
        }
        
        for i in 0...nums.count - 1 {
            result[i] = leftSum[i] * rightSum[i]
        }
        
        return result
    }
    
//    678. Valid Parenthesis String
//    https://leetcode.com/problems/valid-parenthesis-string/
    func checkValidString(_ s: String) -> Bool {
        let sArray = s.compactMap{String($0)}
        
        var leftWild = 0
        for character in sArray {
            if character == ")" {
                if leftWild == 0 {return false}
                leftWild -= 1
            } else {
                leftWild += 1
            }
        }
        
        
        var left = 0
        for character in sArray {
            if character == "(" {
                left += 1
            } else {
                left = max(0, left - 1)
            }
        }
        
        return left == 0
    }
    
//    200. Number of Islands
//    https://leetcode.com/problems/number-of-islands/
    func numIslands(_ grid: [[String]]) -> Int {
        func dfs(_ grid: inout [[String]], i: Int, j: Int) -> Int{
            if i < 0 || i > grid.count - 1 || j < 0 || j > grid[i].count - 1 || grid[i][j] == "0" {
                return 0
            }
            
            grid[i][j] = "0"
            dfs(&grid, i: i+1, j: j)
            dfs(&grid, i: i-1, j: j)
            dfs(&grid, i: i, j: j+1)
            dfs(&grid, i: i, j: j-1)
            return 1
        }
        
        guard grid.count != 0 else {return 0}
        
        var copyGrid = grid
        var numberOfIsland = 0
        for i in 0...copyGrid.count-1 {
            for j in 0...copyGrid[i].count-1{
                if copyGrid[i][j] == "1" {
                    numberOfIsland += dfs(&copyGrid, i: i, j: j)
                }
            }
        }
        
        return numberOfIsland
    }
    
//    33. Search in Rotated Sorted Array
//    https://leetcode.com/problems/search-in-rotated-sorted-array/
    func search(_ nums: [Int], _ target: Int) -> Int {
        func findPivot(_ nums: [Int], left: Int, right: Int) -> Int {
            if right < left {return -1}
            if right == left {return left}

            let mid = (left + right)/2
            
            if mid < right && nums[mid] > nums[mid + 1] {
                return mid
            }
            
            if mid > left && nums[mid] < nums[mid - 1] {
                return mid - 1
            }
            
            
            if nums[left] < nums[mid] {
                // pivot point is on the right
                return findPivot(nums, left: mid+1, right: right)
            } else {
                // pivot point is on the lft
                return findPivot(nums, left: left, right: mid-1)
            }
        }
        
        func binarySearch(_ nums: [Int], left: Int, right: Int, key: Int) -> Int{
            if left > right {return -1}
            let mid = (left + right)/2
            
            if key == nums[mid] {
                return mid
            }
            
            if key > nums[mid] {
                return binarySearch(nums, left: mid+1, right: right, key: key)
            } else {
                return binarySearch(nums, left: left, right: mid-1, key: key)
            }
        }
        
        func pivotedBinarySearch(_ nums: [Int], n: Int, key: Int) -> Int{
            let pivot = findPivot(nums, left: 0, right: n - 1)
            
            if pivot == -1 {
                return binarySearch(nums, left: 0, right: n-1, key: key)
            }
            print("search")
            if nums[pivot] == key {
                return pivot
            }
            
            print("search")
            if nums[0] <= key {
                return binarySearch(nums, left: 0, right: pivot - 1, key: key)
            }
            
            return binarySearch(nums, left: pivot + 1, right: n-1, key: key)
        }
        
        return pivotedBinarySearch(nums, n: nums.count, key: target)
    }
    
//    64. Minimum Path Sum
//    https://leetcode.com/problems/minimum-path-sum/
    
    typealias Pos = (row: Int, column: Int)

    func minPathSum(_ grid: [[Int]]) -> Int {
        guard grid.count > 0 else {return 0}
        guard let firstGrid = grid.first else {return 0}
        var grid = grid
        let n = grid.count
        let m = firstGrid.count
        
        for i in 0...n-1 {
            for j in 0...m-1{
                if i > 0 && j > 0 {
                    grid[i][j] += min(grid[i-1][j], grid[i][j-1])
                } else if i > 0 {
                    grid[i][j] += grid[i-1][j]
                } else if j > 0 {
                    grid[i][j] += grid[i][j-1]
                }
            }
        }
        
        return grid[n-1][m-1]
    }
    
//    1008. Construct Binary Search Tree from Preorder Traversal
//    https://leetcode.com/problems/construct-binary-search-tree-from-preorder-traversal/
    func bstFromPreorder(_ preorder: [Int]) -> TreeNode? {
        guard preorder.count > 0 else {return nil}
        guard let rootValue = preorder.first else {return nil}
        
        let root = TreeNode(rootValue)
        var i = 1
        while i < preorder.count {
            var traverse = root
            let newNode = TreeNode(preorder[i])
            while (true) {
                if traverse.val > preorder[i] {
                    if let leftNode = traverse.left {
                        traverse = leftNode
                    } else {
                        traverse.left = newNode
                        break
                    }
                } else {
                    if let rightNode = traverse.right {
                        traverse = rightNode
                    } else {
                        traverse.right = newNode
                        break
                    }
                }
            }
            i = i + 1
        }
        
        return root
    }
}

let solution = Solution3()
print(solution.search([4,5,6,7,0,1,2], 3))

let matrix = [
  [1,3,1],
  [1,5,1],
  [4,2,1]
]

solution.minPathSum(matrix)

let grid = [
  ["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
]

solution.numIslands(grid)
print(solution.bstFromPreorder([8,5,1,7,10,12]))



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
