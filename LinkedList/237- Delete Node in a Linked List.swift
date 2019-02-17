//replace the value of the node we want to delete with the value in the node after it, and then delete the node after it

func deleteNode(_ node: inout ListNode?) {
    if node == nil || node?.next == nil {
        node = nil
        return
    }
    
    node?.val = node!.next!.val
    node?.next = node?.next?.next
}

