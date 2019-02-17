func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
    //return max left + max right
    if root == nil { return 0 }
    var maxD: Int = 0
    getDepth(root, &maxD)
    return maxD - 1
}

func getDepth(_ root: TreeNode?, _ maxD: inout Int) -> Int {
    var depth = 0
    if root == nil { return depth }
    
    let left = getDepth(root!.left, &maxD)
    let right = getDepth(root!.right, &maxD)
    
    maxD = max(maxD, left+right+1)
    
    return max(left, right) + 1
}
