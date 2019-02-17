# Leetcode-Swift-Solution
How to crack `Leetcode` problems with Swift!

Before going to any specific Leet code problems, let’s go through some really helpful tricks and tips you need to know. With those tips, you will be able to handle most of the easy problems without too much issue. At the mean time, if you are not familiar with Algorithm big O concept, please check some other places before hand.

There is one more thing I want to mention is each time after you code your solution even AC, make sure you know exactly your algorithm time and space complexity. See if it’s the best or there’s other way to make it better.  In other words, whether your solution is O(n^2)  can be optimized to O(NlogN) or even O(n).

Here is some cheatsheet from [BigO CheatSheet](http://bigocheatsheet.com/)

Image of bigO
Image of Cheatsheet

#### Use `dictionary or set` instead of 2 for loops.
[Two Sum - LeetCode](https://leetcode.com/problems/two-sum/)
Given an array of integers, return indices of the two numbers such that they add up to a specific target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

Original Approach
```swift
for i in 0 ..< nums.count {
    for j in i+1 ..< nums.coun {
        if (nums[j] == target - nums[i]) {
                return [i, j]
      }
   }
}
```

With dictionary we can optimize the Brute Force from o(n^2) to o(n) with O(n) space complexity

```swift
for (index, value) in nums.enumerated(){
            if let existingIndex = dict[target - value] {
                //find one
                resArray.append(existingIndex)
                resArray.append(index)
                return resArray
            } else {
                dict[value] = index
            }
        }
```
#### Indexes of String in Swift 4
Unfortunately,  you can not directly access characters by index with subscript in `String` in swift4. You need either make an `String` Extension or convert string into an Array.
```swift
let array = Array(str)
let c = array[1]

//or make a subscript extension 
extension String {
    subscript (i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
    
    subscript(r: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}

// Example
"abcde"[0]      // a
"abcde"[0...2]  // ab
"abcde"[2..<4]  // cd
```
#### About Heap, Stack, Queue or PriorityQueue in Swift
Unfortunately, there’s also no such sort of algorithm
For stack or queue, we can easily use array alternatively.
```swift
var stack = [Int]()
    
func push(a: Int) {
    self.stack.append(a)
}
func pop(){
    stack = Array(stack.dropLast())
}
    
var queue = [Int]()
    
func enqueue(a: Int) {
   self.queue.append(a)
}
func dequeue(){
   queue = Array(queue.dropFirst())
}
```

For heap and PQ, you can move over to a more detailed solution here: [Swift Algorithm Club: Heap and Priority Queue Data Structure | raywenderlich.com](https://www.raywenderlich.com/586-swift-algorithm-club-heap-and-priority-queue-data-structure)

#### Recursions
To be honest there are a lot problems you can solve easily with recursions.
Especially with tree data structure, for example inorder_preorder_postorder tree traversal problem. [Binary Tree Inorder Traversal - LeetCode](https://leetcode.com/problems/binary-tree-inorder-traversal/submissions/)
```swift
//recursive
func inorderTraversal(_ root: TreeNode?) -> [Int] {
    var ret = [Int]()
    inorderTraversalHelper(root, &ret)
    return ret
}
    
func inorderTraversalHelper(_ root: TreeNode?, _ ret: inout [Int]){
    if root == nil { return }
    inorderTraversalHelper(root?.left, &ret)
    ret.append(root!.val)
    inorderTraversalHelper(root?.right, &ret)
}

```
#### Backtracking
With the following template, a lot of other similar problems can be solved.

1. [Subsets - LeetCode](https://leetcode.com/problems/subsets/)
2. [Subsets II - LeetCode](https://leetcode.com/problems/subsets-ii/)
3. [Permutations - LeetCode](https://leetcode.com/problems/permutations/)
4. [Combination Sum II - LeetCode](https://leetcode.com/problems/combination-sum-ii/)
5. [Combination Sum - LeetCode](https://leetcode.com/problems/combination-sum/)
6. [Palindrome Partitioning - LeetCode](https://leetcode.com/problems/palindrome-partitioning/)

```swift
func subsets2(nums: [Int]) -> [[Int]] {
    var res = [[Int]]()
    var path = [Int]()
    let nums = nums.sorted(by: <)
    _dfs(&res, &path, nums2: nums, 0)
    return res
}
    
private func _dfs(_ res: inout [[Int]], _ path: inout [Int], nums2: [Int], _ index: Int) {
   res.append(Array(path))
        
   for i in index ..< nums2.count {
      path.append(nums2[i])
      _dfs(&res, &path, nums2: nums2, i + 1)
      path.removeLast()
    }
}

```

#### Sliding window
(Solution provided by : [ChaoyangHe - Profile - LeetCode](https://leetcode.com/chaoyanghe))
```java
public List<Integer> slidingWindowTemplateByHarryChaoyangHe(String s, String t) {
        //init a collection or int value to save the result according the question.
        List<Integer> result = new LinkedList<>();
        if(t.length()> s.length()) return result;
        
        //create a hashmap to save the Characters of the target substring.
        //(K, V) = (Character, Frequence of the Characters)
        Map<Character, Integer> map = new HashMap<>();
        for(char c : t.toCharArray()){
            map.put(c, map.getOrDefault(c, 0) + 1);
        }
        //maintain a counter to check whether match the target string.
        int counter = map.size();//must be the map size, NOT the string size because the char may be duplicate.
        
        //Two Pointers: begin - left pointer of the window; end - right pointer of the window
        int begin = 0, end = 0;
        
        //the length of the substring which match the target string.
        int len = Integer.MAX_VALUE; 
        
        //loop at the begining of the source string
        while(end < s.length()){
            
            char c = s.charAt(end);//get a character
            
            if( map.containsKey(c) ){
                map.put(c, map.get(c)-1);// plus or minus one
                if(map.get(c) == 0) counter--;//modify the counter according the requirement(different condition).
            }
            end++;
            
            //increase begin pointer to make it invalid/valid again
            while(counter == 0 /* counter condition. different question may have different condition */){
                
                char tempc = s.charAt(begin);//***be careful here: choose the char at begin pointer, NOT the end pointer
                if(map.containsKey(tempc)){
                    map.put(tempc, map.get(tempc) + 1);//plus or minus one
                    if(map.get(tempc) > 0) counter++;//modify the counter according the requirement(different condition).
                }
                
                /* save / update(min/max) the result if find a target*/
                // result collections or result int value
                
                begin++;
            }
        }
        return result;
    }
```

Swift version template:
```swift
func minWindow(_ s: String, _ t: String) -> String {
        if s.count == 0 || t.count == 0 { return "" }
        if s.count < t.count { return "" }
        let s = Array(s)
        
        var dict: [Character: Int] = [:]
        var counter = 0
        var begin = 0
        var end = 0
        var length = Int.max
        var head = 0
        
        for n in t {
            let c = (dict[n] ?? 0) + 1
            dict[n] = c
        }
        
        counter = dict.keys.count
        
        while(end < s.count){
            if dict[s[end]] != nil {
                let newValue = dict[s[end]]! - 1
                dict[s[end]] = newValue
                if newValue == 0 {
                    counter -= 1
                }
            }
            
            end += 1
            
            while counter == 0 {
                let frontChar = s[begin]
                if dict[frontChar] != nil {
                    let count = dict[frontChar]! + 1
                    dict[frontChar] = count
                    
                    if count > 0{
                        counter += 1
                    }
                }
                
                if end - begin < length {
                    length = end - begin
                    head = begin
                }
                
                begin += 1
            }
        }
        
        if length == Int.max { return "" }
        return String(s[head ... head + length - 1])
    }
```
This can be also used to solve the following problems:

1. [Minimum Window Substring - LeetCode](https://leetcode.com/problems/minimum-window-substring/)
2. [Longest Substring Without Repeating Characters - LeetCode](https://leetcode.com/problems/longest-substring-without-repeating-characters/)
3. [Substring with Concatenation of All Words - LeetCode](https://leetcode.com/problems/substring-with-concatenation-of-all-words/)
4. [Longest substring](https://leetcode.com/problems/longest-substring-with-at-most-two-distinct-characters/)
5. [Find All Anagrams in a String - LeetCode](https://leetcode.com/problems/find-all-anagrams-in-a-string/)
#### Binary search / Quick Sort
Sometime the they may ask you to solve the problem within O(logN) or O(NlogN) so the first thing come into your mind is :
For Binary search:  average time complexity is O(log n) and for quick sort, average time complexity is O(NlogN)

#### Tree
Tree is the most popular type of question in LeetCode as well as in interview. Mostly interviewer will ask a question if algorithm is part of the interview because it’s not a very complicated data structure and not as hard as graph or DP. It is usually be able to solved within 20-30 mins. For example, if two trees are same tree [Same Tree - LeetCode](https://leetcode.com/problems/same-tree) [Symmetric Tree - LeetCode](https://leetcode.com/problems/symmetric-tree) [Lowest Common Ancestor of a Binary Tree - LeetCode](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree) [Validate Binary Search Tree - LeetCode](https://leetcode.com/problems/validate-binary-search-tree)
#### LRU Cache

#### `unicodeScalars` is more efficient Than `Character`. If your code runs timeout should consider the following to revise your solution in `Leetcode`
```swift
if s.count <= 1 {return true}
let lowerS = s.lowercased()
var ints = [UInt32]()
for scalars in lowerS.unicodeScalars {
    ints.append(scalars.value)
}
```#### To Remove empty string and none letters characters
```swift
let cleaned = s.lowercased().filter{ c in
    return c.description.rangeOfCharacter(from: CharacterSet.alphanumerics) != nil && String(c) != “”
}
```#### How to create initialized 2d array
```swift
var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: grid[0].count), count: grid.count)
```

#### How to loop through an array in reverse ( you will need it a lot)

```swift
let array = ["Apples", "Peaches", "Plums"]

for item in array.reversed() {
    print("Found \(item)")
}

for (index, item) in array.reversed().enumerated() {
    print("Found \(item) at position \(index)")
}

for i in stride(from: 5, to: 0, by: -1) {
    print(i)
}
//prints 5, 4, 3, 2, 1

for i in stride(from: 5, through: 0, by: -1) {
    print(i)
}
//prints 5, 4, 3, 2, 1, 0
```

#### When doing 2 pointers, mid element should be calculated in the following way:
```swift
let mi = lo + (hi - lo) / 2
```

#### Simple way to trim an array from an index
```swift
nums[i...] = []
//to clean array after i index.
```

### LinkedList
- [x] 141. [Linked List Cycle - LeetCode](https://leetcode.com/problems/linked-list-cycle/)
Solution:   [Swift](https://github.com/alexliubj/Leetcode-Swift-Solution/blob/master/LinkedList/141-%20Linked%20List%20Cycle.swift)
- [x] 206. [Reverse Linked List - LeetCode](https://leetcode.com/problems/reverse-linked-list/)
Solution:  [Swift](https://github.com/alexliubj/Leetcode-Swift-Solution/blob/master/LinkedList/206-%20Reverse%20linked%20list.swift)
- [x] 160. [Intersection of Two Linked Lists - LeetCode](https://leetcode.com/problems/intersection-of-two-linked-lists/)
Solution:  [Swift](https://github.com/alexliubj/Leetcode-Swift-Solution/blob/master/LinkedList/160-%20Intersection%20of%20two%20Linked%20list.swift)
- [x] 237. [Delete Node in a Linked List - LeetCode](https://leetcode.com/problems/delete-node-in-a-linked-list/)
-Solution:   [Swift](https://github.com/alexliubj/Leetcode-Swift-Solution/blob/master/LinkedList/237.%20Delete%20Node%20in%20a%20Linked%20List.swift)

### Stack

### Queue

### Search

### String

### Tree


### Math

### Heap

### Graph

### DP

### FLAG
