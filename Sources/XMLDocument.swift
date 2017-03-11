//
//  XMLDoc.swift
//  VinFoundation
//
//  Created by Maurice Parker on 1/30/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//

import Foundation
import libxml2

public class XMLDocument: XMLXPath {
    
    var docPtr: xmlDocPtr!
    
    public var raw: String? {
        return root.raw
    }
    
    public convenience init?(xml: String) throws {
        try self.init(data: xml, isXML: true)
    }
    
    public convenience init?(html: String) throws {
        try self.init(data: html, isXML: false)
    }
    
    public init?(data: String, isXML: Bool) throws {
    
        guard !data.isEmpty else { return nil }
        
        let bytes = data.cString(using: .utf8)
        let length = CInt(data.lengthOfBytes(using: .utf8))
        let encoding = CFStringGetCStringPtr(nil, CFStringBuiltInEncodings.UTF8.rawValue)

        let options: CInt = isXML ? 1 : (1 << 5 | 1 << 6)
        let function = isXML ? xmlReadMemory : htmlReadMemory
        
        docPtr = function(bytes, length, "", encoding, options)
        if docPtr == nil {
            return nil
        }
        
    }
    
    public var root: XMLElement {
        return XMLElement.init(doc: self, parent: nil, nodePtr: xmlDocGetRootElement(docPtr))
    }
    
    public func query(xpath: String) throws -> [XMLElement] {
        
        guard let pathCtx = xmlXPathNewContext(docPtr) else { return [] }
        defer { xmlXPathFreeContext(pathCtx) }
        
        guard let xPathObj = xmlXPathEvalExpression(xpath.xmlChars, pathCtx) else { return [] }
        defer { xmlXPathFreeObject(xPathObj) }
        
        guard let nodes = xPathObj.pointee.nodesetval else { return [] }
        
        let nodePtrs = UnsafeBufferPointer(start: nodes.pointee.nodeTab, count: Int(nodes.pointee.nodeNr))
        let xnodes = nodePtrs.flatMap { XMLElement.init(doc: self, parent: nil, nodePtr: $0) }
        
        return xnodes
        
    }
    
    public func replace(this: XMLElement, withThis: XMLElement) {
        xmlReplaceNode(this.nodePtr, withThis.nodePtr)
    }
    
    deinit {
        xmlFreeDoc(docPtr)
    }
    
}
