
//The key to solve this issue is compare existing input value and find what's the next node in the tree
//Input: pre = [1,2,4,5,3,6,7], post = [4,5,2,6,7,3,1]
//Output: [1,2,3,4,5,6,7]
//pre is root, left then right child, post is left, right and root
//If look into pre array, first one is root and it should be the last one in post array

func constructFromPrePost(_ pre: [Int], _ post: [Int]) -> TreeNode? {
    return helper(0, pre.count - 1, 0, post.count-1, pre, post)
}

func helper(_ preStart: Int, _ preEnd: Int, _ postStart: Int, _ postEnd: Int, _ pre: [Int], _ post: [Int]) -> TreeNode? {
    //edge cases
    if preStart > preEnd {
        return nil
    }
    
    if ( preStart == preEnd ) {
        return TreeNode(pre[preStart])
    }
    
    var root: TreeNode? = TreeNode(pre[preStart])
    
    var val = pre[preStart + 1]
    var postIndex = 0
    
    for i in postStart ... postEnd {
        if post[i] == val {
            postIndex = i
            break
        }
    }
    
    let countLeft = postIndex - postStart
    root?.left = helper(preStart + 1, preStart + 1 + countLeft, postStart, postIndex - 1, pre, post)
    root?.right = helper(preStart + 1 + countLeft + 1, preEnd, postIndex + 1, postEnd - 1,pre, post)
    
    return root
}
