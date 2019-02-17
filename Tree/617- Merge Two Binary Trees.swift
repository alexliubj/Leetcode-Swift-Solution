
//recursively call mergeTrees on root, left and right
//return new root with new left child and right child as function return value
func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
    guard let t1 = t1 else {
        return t2
    }
    
    guard let t2 = t2 else {
        return t1
    }
    
    let newRoot = TreeNode(t1.val + t2.val)
    let left = mergeTrees(t1.left, t2.left)
    let right = mergeTrees(t1.right, t2.right)
    
    newRoot.left = left
    newRoot.right = right
    
    return newRoot
}
