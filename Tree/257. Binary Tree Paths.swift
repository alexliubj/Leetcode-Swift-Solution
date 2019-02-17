
func binaryTreePaths(_ root: TreeNode?) -> [String] {
    if root == nil { return [String]() }
    else {
        var paths: [String] = []
        self.travel(root, path: "", &paths)
        return paths
    }
}

func travel(_ root: TreeNode?, path: String, _ paths: inout [String]){
    if root?.left == nil && root?.right == nil {
        let finalPath = path + "\(root!.val)"
        paths.append(finalPath)
    }
    
    if root?.left != nil{
        self.travel(root?.left, path: path + "\(root!.val)->", &paths)
    }
    
    if root?.right != nil{
        self.travel(root?.right, path: path + "\(root!.val)->", &paths)
    }
}
