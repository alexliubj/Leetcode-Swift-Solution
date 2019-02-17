func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
    var sum = 0
    guard let root = root else {
        return sum
    }
    
    sumNode(false, node: root, sum: &sum)
    
    return sum
}

func sumNode(_ isLeft: Bool, node: TreeNode?, sum: inout Int){
    guard let node = node else {
        return
    }
    
    if isLeft && node.left == nil && node.right == nil{
        sum += node.val
    }
    
    sumNode(true, node: node.left, sum: &sum)
    sumNode(false, node: node.right, sum: &sum)
}
