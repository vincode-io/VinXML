//
//  XMLAttributeTests.swift
//  VinXML
//
//  Created by Maurice Parker on 3/7/17.
//
//

import XCTest
@testable import VinXML

class XMLAttributeTests: XMLBaseTest {
    
    
    func testCreateAttribute() throws {
        
        let doc = try XMLDocument(html: testHTML)

        let firstPara = try doc?.queryFirst(xpath: "//*[@id='first']")
        XCTAssertNotNil(firstPara)
        XCTAssertEqual(1, firstPara?.attributes.count)

        let newAttr = firstPara?.attributes.append(name: "counter", content: "3")
        XCTAssertNotNil(newAttr)
        
        let testPara = try doc?.queryFirst(xpath: "//*[@id='first']")
        XCTAssertEqual(2, firstPara?.attributes.count)
        XCTAssertEqual("3", testPara?.attributes["counter"]!.content!)
        
    }

    func testRemoveAttribute() throws {
        
        let doc = try XMLDocument(html: testHTML)
        
        let firstPara = try doc?.queryFirst(xpath: "//*[@id='first']")
        XCTAssertNotNil(firstPara)
        
        let firstAttr = firstPara!.attributes["id"]
        try firstPara!.attributes.remove(firstAttr!)

        let notFoundAttr = try doc?.queryFirst(xpath: "//*[@id='first']")
        XCTAssertNil(notFoundAttr)
        
    }
    
    func testUpdateAttributeContent() throws {
        
        let doc = try XMLDocument(html: testHTML)
        
        let firstPara = try doc?.queryFirst(xpath: "//*[@id='first']")
        XCTAssertNotNil(firstPara)
        
        firstPara!.attributes["id"]?.content = "newContent"
        XCTAssertEqual("newContent", firstPara!.attributes["id"]?.content)
        
        let xpathLookup = try doc?.queryFirst(xpath: "//*[@id='newContent']")
        XCTAssertNotNil(xpathLookup)
        
    }
    
}
