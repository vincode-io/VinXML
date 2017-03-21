//
//  XMLTreeTests.swift
//  VinFoundation
//
//  Created by Maurice Parker on 2/4/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//

import XCTest
@testable import VinXML

class XMLDocTests: XMLBaseTest {
    
    func testTraversal() {
        
        do {
            
            let doc = try loadHTHLDoc()
            
            let root = doc.root
            XCTAssertNotNil(root)
            
            let head = root?.firstChild(forName: "head")
            XCTAssertNotNil(head)
            XCTAssertEqual(head!.type, XMLElementType.ElementNode)
            
            let metas = head!.children(forName: "meta")
            XCTAssertNotNil(metas)
            XCTAssertEqual(metas.count, 14)
            
        } catch {
            XCTFail("\(error)")
        }
        
    }
    
    func testRemoveByXpath() throws {
        
        let doc = try XMLDocument(html: testHTML)
        
        var paras = try doc?.query(xpath: "//*/p")
        XCTAssertEqual(3, paras?.count)
        
        try doc?.remove(xpath: "//*[@id='second']")
        
        paras = try doc?.query(xpath: "//*/p")
        XCTAssertEqual(2, paras?.count)
        
    }

}
