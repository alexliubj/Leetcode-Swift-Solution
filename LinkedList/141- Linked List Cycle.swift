 
 //Set 2 pointers
 //slow one move 1 step and fast one moves 2 steps at the same time
 //if fast pointer can be same as slow one before reaches the end of linked list then we can say this LinkedList has cycle.
 
 func hasCycle(_ head: ListNode?) -> Bool {
    if head == nil {
        return false
    }
    
    var slow = head
    var fast = head
    
    while fast?.next != nil && fast?.next?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        if slow === fast {
            return true
        }
    }
    
    return false
 }
