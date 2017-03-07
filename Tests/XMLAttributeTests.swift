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
        
        let doc = try XMLDoc(html: testHTML)

        let firstPara = try doc.queryFirst(xpath: "//*[@id='first']")
        XCTAssertNotNil(firstPara)
        XCTAssertEqual(1, firstPara?.attributes.count)

        let newAttr = firstPara?.attributes.append(name: "counter", content: "3")
        XCTAssertNotNil(newAttr)
        
        let testPara = try doc.queryFirst(xpath: "//*[@id='first']")
        XCTAssertEqual(2, firstPara?.attributes.count)
        XCTAssertEqual("3", testPara?.attributes["counter"]!.content!)
        
    }

    
}
