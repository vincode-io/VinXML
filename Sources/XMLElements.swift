//
//  XMLElements.swift
//  VinXML
//
//  Created by Maurice Parker on 3/4/17.
//  Copyright © 2017 Vincode. All rights reserved.
//

public class XMLElements: Sequence {
    
    var root: XMLElement?

    public init(root: XMLElement?) {
        self.root = root
    }
    
    public init(doc: XMLDocument?, parent: XMLElement?) {
        guard let firstChildNodePtr = parent?.nodePtr.pointee.children else { return }
        self.root = XMLElement(doc: doc, parent: parent, nodePtr: firstChildNodePtr)
    }
    
    public var isEmpty: Bool {
        return root == nil
    }
    
    public var first: XMLElement? {
        return root
    }
    
    public func index(of findElement: XMLElement) -> Int? {
        for (i, element) in self.enumerated() {
            if findElement == element {
                return i
            }
        }
        return nil
    }
    
    public subscript(index: Int) -> XMLElement? {
        for (i, element) in self.enumerated() {
            if i == index {
                return element
            }
        }
        return nil
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
