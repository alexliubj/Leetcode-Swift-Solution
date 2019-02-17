class Solution {
    func isSubtree(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
        
        if s == nil || t == nil { return false }
        
        if s?.val == t?.val && hasSameSub(s, t) { return true }
        
        return isSubtree(s?.left, t) || isSubtree(s?.right, t)
    }
    
    func hasSameSub(_ s: TreeNode?, _ t: TreeNode?) -> Bool{
        if s == nil || t == nil {  return s == t }
        
        let sameValue = s?.val == t?.val
        if !sameValue { return false }
        
        let sameLeft = hasSameSub(s?.left, t?.left)
        let sameRight = hasSameSub(s?.right, t?.right)
        
        return sameValue && sameLeft && sameRight
    }
}

extension TreeNode: Equatable{
    public static func == (_ lhs: TreeNode, _ rhs: TreeNode) -> Bool{
        return lhs.val == rhs.val
    }
}
