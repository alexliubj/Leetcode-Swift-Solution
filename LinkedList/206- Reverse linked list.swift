/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */
class Solution {
    //recursive
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        else {
            var newHead: ListNode? = self.reverseList(head?.next)
            newHead?.next = head
            head?.next = nil
            return newHead
        }
    }
    
    func reverseList2(_ head: ListNode?) -> ListNode? {
        guard let _ = head else { return nil }
        
        var pre = head
        var cur = head?.next
        var temp = head?.next?.next
        
        while cur != nil {
            temp = cur?.next
            cur?.next = pre
            pre = cur
            cur = temp
        }
        
        head?.next = nil
        return pre
    }
}
