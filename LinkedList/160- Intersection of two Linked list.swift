//Maintain two pointers pA and pB initialized at the head of A and B, respectively. Then let them both traverse through the lists, one node at a time.
//When pA reaches the end of a list, then redirect it to the head of B (yes, B, that's right.); similarly when pB reaches the end of a list, redirect it the head of A.
//If at any point pA meets pB, then pA/pB is the intersection node.
// https://leetcode.com/problems/intersection-of-two-linked-lists/solution/
//Time complexity : O(m+n).
//Space: O(1)

func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
    
    if headA == nil || headB == nil {
        return nil
    }
    
    var ha: ListNode? = headA
    var hb: ListNode? = headB
    
    while ha != hb {
        ha = ha == nil ? headB : ha?.next
        hb = hb == nil ? headA : hb?.next
    }
    
    return ha
}

