//
//  XMLAttributes.swift
//  VinFoundation
//
//  Created by Maurice Parker on 2/25/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//
import libxml2

public class XMLAttributes: Collection {

    unowned var parent: XMLElement

    init(parent: XMLElement) {
        self.parent = parent
    }

    public var startIndex: String {
      
        if let firstAttr = parent.nodePtr.pointee.properties {
            let attribute = XMLAttribute(parent: parent, attrPtr: firstAttr)
            return attribute.name ?? String()
        }
        
        return String()
    }
    
    public var endIndex: String {

        var curAttr = parent.nodePtr.pointee.properties
        var lastAttr: xmlAttrPtr?
        while curAttr != nil {
            lastAttr = curAttr
            curAttr = curAttr!.pointee.next
        }
        
        guard lastAttr != nil else {
            return String()
        }
        
        let attribute = XMLAttribute(parent: parent, attrPtr: lastAttr!)
        return attribute.name ?? String()
        
    }
    
    public var count: Int {
        var counter = 0
        var curAttr = parent.nodePtr.pointee.properties
        while curAttr != nil {
            counter = counter + 1
            curAttr = curAttr!.pointee.next
        }
        return counter
    }
    
    public func index(after i: String) -> String {
        if let current = self[i] {
            return (current.next?.name ?? String())
        }
        return String()
    }
    
    public subscript(index: String) -> XMLAttribute? {

        if let attrPtr = xmlHasProp(parent.nodePtr, index.xmlChars) {
            return XMLAttribute(parent: parent, attrPtr: attrPtr)
        }
        
        return nil
        
    }
    
    public func append(name: String, content: String) -> XMLAttribute? {
        if let attrPtr = xmlNewProp(parent.nodePtr, name.xmlChars, content.xmlChars) {
            return XMLAttribute(parent: parent, attrPtr: attrPtr)
        }
        return nil
    }
    
    public func remove(_ attribute: XMLAttribute) throws {
        try attribute.remove()
    }
    
}
