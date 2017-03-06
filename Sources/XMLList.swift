//
//  XMLList.swift
//  VinFoundation
//
//  Created by Maurice Parker on 2/3/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//

import Foundation
import libxml2

class XMLList<T> : Sequence {
    
    typealias Node = UnsafeMutablePointer<T>?
    
    var current: Node
    var next: Node { return nil }
    
    init(head: Node) {
        self.current = head
    }
    
    func makeIterator() -> AnyIterator<UnsafeMutablePointer<T>> {
        
        return AnyIterator {
            
            guard self.current != nil else { return nil }
            let c = self.current!
            self.current = self.next
            return c
            
        }
        
    }
    
}

class XMLAttrList : XMLList<xmlAttr> {
    override var next: Node { return current?.pointee.next }
    override init(head: Node) { super.init(head: head) }
}

class XMLElementList : XMLList<xmlNode> {
    override var next: Node { return current?.pointee.next }
    override init(head: Node) { super.init(head: head) }
}
