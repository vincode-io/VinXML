//
//  XMLAttribute.swift
//  VinFoundation
//
//  Created by Maurice Parker on 1/31/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//

import Foundation
import libxml2

//public class XMLAttribute: XMLNode {
public class XMLAttribute {
    
    private var parent: XMLElement
    private var attrPtr: UnsafeMutablePointer<xmlAttr>

    init(parent: XMLElement, attrPtr: UnsafeMutablePointer<xmlAttr>) {
        self.parent = parent
        self.attrPtr = attrPtr
    }

    public var name: String? {
        get {
            if let name = attrPtr.pointee.name {
                return String(cString: name)
            }
            return nil
        }
    }
    
    public var content: String? {
        get {
            if let name = attrPtr.pointee.name {
                let prop = xmlGetProp(parent.nodePtr, name)
                defer { xmlFree(prop) }
                if prop != nil {
                    return String(cString: prop!)
                }
            }
            return nil
        }
    }

    public var next: XMLAttribute? {
        get {
            if let nextSibling = attrPtr.pointee.next {
                return XMLAttribute(parent: parent, attrPtr: nextSibling)
            }
            return nil
        }
    }
    
}
