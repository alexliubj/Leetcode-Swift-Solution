func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
    var stack = [TreeNode]()
    var ret = 0
    //for empty tree, return 0?
    guard root != nil else { return 0 }
    var root = root
    var k = k
    
    while root != nil {
        stack.append(root!)
        root = root!.left
    }
    
    while k > 0 {
        
        let n = stack.last
        stack.remove(at: stack.count - 1)
        
        if k == 1 {
            return n!.val
        }
        
        if n!.right != nil {
            var right = n!.right!
            stack.append(right)
            
            while(right.left != nil) {
                stack.append(right.left!)
                right = right.left!
            }
        }
        
        k -= 1
    }
    
    return ret
}
