//
//  XMLNode.swift
//  VinXML
//
//  Created by Maurice Parker on 1/31/17.
//  Copyright © 2017 Vincode. All rights reserved.
//

import libxml2

public class XMLNode: XMLXPath, XMLVisitorHost, Equatable {

    public var doc: XMLDocument?
    public weak var parent: XMLNode?
    var nodePtr: xmlNodePtr!
    
    public var name: String? {
        get {
            if let name = nodePtr.pointee.name {
                return String(cString: name)
            } else {
                return nil
            }
        }
        set {
            guard let newValue = newValue else {
                return
            }
            xmlNodeSetName(nodePtr, newValue.xmlChars)
        }
    }
    
	/// Returns all the text under this element including from child elements
    public var content: String? {
        let content = xmlNodeGetContent(nodePtr)
        defer { xmlFree(content) }
        if content != nil {
            return String(cString: content!).trimmed()
        } else {
            return nil
        }
    }
    
	/// Only returns the text content for this element
    public var text: String? {
        let text = xmlNodeListGetString(doc?.docPtr, nodePtr.pointee.children, 1)
        defer { xmlFree(text) }
        if text != nil {
            return String(cString: text!).trimmed()
        } else {
            return nil
        }
    }
    
    public var hasContent: Bool {
        return content != nil
    }
    
    public var hasText: Bool {
        return text != nil
    }
    
    public var raw: String? {
        if let buffer = xmlBufferCreate() {
            xmlNodeDump(buffer, doc!.docPtr, nodePtr, 0, 1)
            defer { xmlBufferFree(buffer) }
            return String(cString: buffer.pointee.content)
        } else {
            return nil
        }
    }
    
    public var html: String? {
        if let buffer = xmlBufferCreate() {
            htmlNodeDump(buffer, doc!.docPtr, nodePtr)
            defer { xmlBufferFree(buffer) }
            return String(cString: buffer.pointee.content)
        } else {
            return nil
        }
    }

	public lazy var attributes: XMLAttributes = XMLAttributes(parent: self)
	public lazy var type: XMLNodeType = XMLNodeType(rawValue: Int(self.nodePtr.pointee.type.rawValue))!

    private lazy var siblings: XMLNodes = XMLNodes(root: self)
	private lazy var children: XMLNodes = XMLNodes(doc: self.doc, parent: self)
   
    public init?(doc: XMLDocument?, parent: XMLNode?, nodePtr: xmlNodePtr!) {
        self.doc = doc
        self.parent = parent
        self.nodePtr = nodePtr
        if nodePtr == nil {
            return nil
        }
    }
    
    public func query(xpath: String) throws -> [XMLNode] {
        guard let xPathObj = xmlXPathNodeEval(nodePtr, xpath.xmlChars, doc?.pathCtxPtr) else { return [] }
        defer { xmlXPathFreeObject(xPathObj) }
        
        guard let nodes = xPathObj.pointee.nodesetval else { return [] }
        
        let nodePtrs = UnsafeBufferPointer(start: nodes.pointee.nodeTab, count: Int(nodes.pointee.nodeNr))
        let xnodes = nodePtrs.compactMap { XMLNode.init(doc: doc, parent: nil, nodePtr: $0) }
        
        return xnodes
    }
    
    public func remove() throws {
        xmlUnlinkNode(nodePtr)
        xmlFreeNode(nodePtr)
    }

    //MARK: Useful traversal functions.

	public subscript(_ name: String) -> [XMLNode]? {
		let results = self.children.filter {
			if doc?.caseSensitive ?? true {
				return $0.name == name
			} else {
				return $0.name?.caseInsensitiveCompare(name) == .orderedSame
			}
		}
		return results.isEmpty ? nil : results
	}
	
    public func nextSibling() -> XMLNode? {
        if let nextNodePtr = xmlNextElementSibling(nodePtr) {
            return XMLNode.init(doc: doc, parent: parent, nodePtr: nextNodePtr)
        }
        return nil
    }
    
    static public func == (lhs: XMLNode, rhs: XMLNode) -> Bool {
        return lhs.nodePtr == rhs.nodePtr
    }
    
    // MARK: Visitor
    public func host(visitor: XMLVisitor) throws {
        if try visitor.visit(host: self) {
            try children.forEach() { node in
                try node.host(visitor: visitor)
            }
        }
    }
    
}

extension XMLNode: Sequence {
	
	public var isEmpty: Bool {
		return children.isEmpty
	}
	
	public var first: XMLNode? {
		return children.first
	}
	
	public func index(of findElement: XMLNode) -> Int? {
		return children.index(of: findElement)
	}
	
	public subscript(index: Int) -> XMLNode? {
		return children[index]
	}
	
	public func makeIterator() -> AnyIterator<XMLNode> {
		return children.makeIterator()
	}
}
