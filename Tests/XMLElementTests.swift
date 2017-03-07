//
//  XMLRemoveElementTests.swift
//  VinFoundation
//
//  Created by Maurice Parker on 2/9/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//

import XCTest
@testable import VinXML

class XMLElementTests: XMLBaseTest {
    

    func testRenameNode() throws {
        
        let doc = try XMLDoc(html: testHTML)
        
        var docDivs = try doc?.query(xpath: "//*/div")
        XCTAssertEqual(6, docDivs?.count)
        
        docDivs?[3].name = "span"
        
        docDivs = try doc?.query(xpath: "//*/div")
        XCTAssertEqual(5, docDivs?.count)
        
        let spanDivs = try doc?.query(xpath: "//*/span")
        XCTAssertEqual(1, spanDivs?.count)
        
    }
    
    func testNextSibling() throws {
        
        let doc = try XMLDoc(html: testHTML)
        let firstPara = try doc?.queryFirst(xpath: "//*[@id='first']")
        
        var nextElement = firstPara!.nextSibling()
        XCTAssertEqual("p1div1", nextElement!.attributes["id"]!.content)
        
        nextElement = nextElement!.nextSibling()
        XCTAssertEqual("p1div2", nextElement!.attributes["id"]!.content)
    
    }
    
//    func testRemoveByXpath() throws {
//        
//        let doc = try XMLDoc(html: testHTML)
//
//        var docDivs = try doc.query(xpath: "//*/div")
//        XCTAssertEqual(6, docDivs.count)
//        
//        let thirdPara = try doc.queryFirst(xpath: "//*[@id='third']")
//        var thirdParaDivs = try thirdPara!.query(xpath: "./div")
//        XCTAssertEqual(3, thirdParaDivs.count)
//        
//        try thirdPara!.remove(xpath: "//*[@id='p3div3']")
//        
//        thirdParaDivs = try thirdPara!.query(xpath: "div")
//        XCTAssertEqual(2, thirdParaDivs.count)
//
//        docDivs = try doc.query(xpath: "//*/div")
//        XCTAssertEqual(5, docDivs.count)
//        
//        
//    }

}
