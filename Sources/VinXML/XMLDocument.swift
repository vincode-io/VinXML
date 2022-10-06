//
//  XMLDoc.swift
//  VinXML
//
//  Created by Maurice Parker on 1/30/17.
//  Copyright © 2017 Vincode. All rights reserved.
//

import Foundation
import libxml2

public class XMLDocument: XMLXPath {
    
    var docPtr: xmlDocPtr!
    var pathCtxPtr: xmlXPathContextPtr!
	var caseSensitive: Bool
    
    public var raw: String? {
        return root?.raw
    }
    
	public convenience init?(xml: Data, caseSensitive: Bool = true) throws {
		guard let xmlString = String(data: xml, encoding: .utf8) else { return nil }
		try self.init(string: xmlString, isXML: true, caseSensitive: caseSensitive)
	}
	
	public convenience init?(xml: String, caseSensitive: Bool = true) throws {
        try self.init(string: xml, isXML: true, caseSensitive: caseSensitive)
    }
    
	public convenience init?(html: Data, caseSensitive: Bool = true) throws {
		guard let htmlString = String(data: html, encoding: .utf8) else { return nil }
		try self.init(string: htmlString, isXML: false, caseSensitive: caseSensitive)
	}
	
    public convenience init?(html: String, caseSensitive: Bool = true) throws {
        try self.init(string: html, isXML: false, caseSensitive: caseSensitive)
    }
    
    init?(string: String, isXML: Bool, caseSensitive: Bool = true) throws {
        guard !string.isEmpty else { return nil }
        
        let bytes = string.cString(using: .utf8)
        let length = CInt(string.lengthOfBytes(using: .utf8))
        let encoding = CFStringGetCStringPtr(nil, CFStringBuiltInEncodings.UTF8.rawValue)

        let options: CInt = isXML ? 1 : (1 << 5 | 1 << 6)
        let function = isXML ? xmlReadMemory : htmlReadMemory
        
        docPtr = function(bytes, length, "", encoding, options)
        if docPtr == nil {
            return nil
        }

        pathCtxPtr = xmlXPathNewContext(docPtr)

		self.caseSensitive = caseSensitive
    }
    
    public var root: XMLNode? {
        return XMLNode.init(doc: self, parent: nil, nodePtr: xmlDocGetRootElement(docPtr))
    }
    
    public func registerXPathNamespace(prefix: String, url: String) {
        xmlXPathRegisterNs(pathCtxPtr, prefix.xmlChars, url.xmlChars)
    }
    
    public func query(xpath: String) throws -> [XMLNode] {
        guard let xPathObj = xmlXPathEvalExpression(xpath.xmlChars, pathCtxPtr) else { return [] }
        defer { xmlXPathFreeObject(xPathObj) }
        
        guard let nodes = xPathObj.pointee.nodesetval else { return [] }
        
        let nodePtrs = UnsafeBufferPointer(start: nodes.pointee.nodeTab, count: Int(nodes.pointee.nodeNr))
        let xnodes = nodePtrs.compactMap { XMLNode.init(doc: self, parent: nil, nodePtr: $0) }
        
        return xnodes
    }
    
    public func replace(this: XMLNode, withThis: XMLNode) {
        xmlReplaceNode(this.nodePtr, withThis.nodePtr)
    }
    
    deinit {
        xmlFreeDoc(docPtr)
        xmlXPathFreeContext(pathCtxPtr)
    }
    
}
