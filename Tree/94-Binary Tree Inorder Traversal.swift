import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

//stack
func inorderTraversal(_ root: TreeNode?) -> [Int] {
    var ret = [Int]()
    var stack = [TreeNode]()
    var root = root
    
    while root != nil || stack.count != 0 {
        if root != nil {
            stack.append(root!)
            root = root?.left
        }else{
            if stack.count != 0 {
                root = stack[stack.count - 1]
                stack.remove(at: stack.count - 1)
                ret.append(root!.val)
                root = root?.right
            }
        }
    }
    
    return ret
}

//recursive
func inorderTraversal2(_ root: TreeNode?) -> [Int] {
    var ret = [Int]()
    _inorderTraversal(root, &ret)
    return ret
}

func _inorderTraversal(_ root: TreeNode?, _ ret: inout [Int]){
    if root == nil { return }
    _inorderTraversal(root?.left, &ret)
    ret.append(root!.val)
    _inorderTraversal(root?.right, &ret)
}
