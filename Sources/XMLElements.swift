//
//  XMLElements.swift
//  VinFoundation
//
//  Created by Maurice Parker on 3/4/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//

import Foundation

public class XMLElements: Sequence {
    
    var root: XMLElement?

    public init(root: XMLElement?) {
        self.root = root
    }
    
    public init(doc: XMLDocument?, parent: XMLElement?) {
        guard let firstChildNodePtr = parent?.nodePtr.pointee.children else { return }
        self.root = XMLElement(doc: doc, parent: parent, nodePtr: firstChildNodePtr)
    }
    
    var isEmpty: Bool {
        return root == nil
    }
    
    var first: XMLElement? {
        return root
    }
    
    public func makeIterator() -> AnyIterator<XMLElement> {
        
        var iteratorCurrent = root

        return AnyIterator {
            
            guard iteratorCurrent != nil else { return nil }
            
            let temp = iteratorCurrent!
            iteratorCurrent = temp.nextSibling()
            return temp
            
        }
        
    }
    
}
