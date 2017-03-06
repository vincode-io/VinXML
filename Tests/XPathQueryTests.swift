//
//  XPathQueryTests.swift
//  VinFoundation
//
//  Created by Maurice Parker on 1/30/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//

import XCTest
@testable import VinXML

class XPathQueryTests: XMLBaseTest {
    
    func testElementContent() {
        
        do {
            
            let doc = try loadHTHLDoc()
            
            let xpath = "//*[@class='entry-title']"
            let element = try doc.queryFirst(xpath: xpath)
            XCTAssertNotNil(element)
            
            XCTAssertEqual(element?.content, "Company")
            
        } catch {
            XCTFail("\(error)")
        }
        
    }
    
    func testPropertyContent() {
        
        do {
            
            let doc = try loadHTHLDoc()
            
            let xpath = "//*[@property='og:description']"
            let element = try doc.queryFirst(xpath: xpath)
            XCTAssertNotNil(element)
            
            let contentAttr = element?.attributes["content"]
            XCTAssertNotNil(contentAttr)

            XCTAssertEqual(contentAttr?.content, "Mobile and Web Development")
            
        } catch {
            XCTFail("\(error)")
        }
        
    }
    
}
