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

    public init(doc: XMLDoc?, parent: XMLElement?) {
        guard let firstChildNodePtr = parent?.nodePtr.pointee.children else { return }
        self.root = XMLElement(doc: doc, parent: parent, nodePtr: firstChildNodePtr)
    }
    
    var isEmpty: Bool {
        get {
            return root == nil
        }
    }
    
    var first: XMLElement? {
        get {
            return root
        }
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
