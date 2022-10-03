//
//  XMLTreeTests.swift
//  VinFoundation
//
//  Created by Maurice Parker on 2/4/17.
//  Copyright © 2017 Vincode. All rights reserved.
//

import XCTest
@testable import VinXML

class XMLDocTests: XMLBaseTest {
    
    func testTraversal() {
        
        do {
            
            let doc = try loadHTHLDoc()
            
            let root = doc.root
            XCTAssertNotNil(root)
            
			let head = root?["head"]?.first
            XCTAssertNotNil(head)
            XCTAssertEqual(head!.type, XMLNodeType.ElementNode)
            
            let metas = head!["meta"]
            XCTAssertNotNil(metas)
            XCTAssertEqual(metas!.count, 12)
            
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
