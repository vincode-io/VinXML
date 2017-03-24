//
//  XMLRemoveElementTests.swift
//  VinFoundation
//
//  Created by Maurice Parker on 2/9/17.
//  Copyright © 2017 Vincode. All rights reserved.
//

import XCTest
@testable import VinXML

class XMLElementTests: XMLBaseTest {
    

    func testRenameNode() throws {
        
        let doc = try XMLDocument(html: testHTML)
        
        var spans = try doc?.query(xpath: "//*/span")
        XCTAssertEqual(6, spans?.count)
        
        spans?[3].name = "em"
        
        spans = try doc?.query(xpath: "//*/span")
        XCTAssertEqual(5, spans?.count)
        
        let ems = try doc?.query(xpath: "//*/em")
        XCTAssertEqual(1, ems?.count)
        
    }
    
    func testNextSibling() throws {
        
        let doc = try XMLDocument(html: testHTML)
        let firstPara = try doc?.queryFirst(xpath: "//*[@id='first']")
        
        var nextElement = firstPara!.nextSibling()
        XCTAssertEqual("second", nextElement!.attributes["id"]!.content)
        
        nextElement = nextElement!.nextSibling()
        XCTAssertEqual("third", nextElement!.attributes["id"]!.content)
    
    }
    
    func testSearches() throws {
    
        let doc = try XMLDocument(html: testHTML)
        let thirdPara = try doc?.queryFirst(xpath: "//*[@id='third']")
        
        let filterSpans = thirdPara?.children(forName: "span")
        XCTAssertEqual(3, filterSpans?.count)
        
        let spans = try thirdPara?.query(xpath: ".//span")
        XCTAssertEqual(3, spans?.count)
        
    }

}
