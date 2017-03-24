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
    
    func testNameSpaceQuery() throws {
        
        let xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
        "<package xmlns=\"http://www.idpf.org/2007/opf\" version=\"3.0\" xml:lang=\"en\" unique-identifier=\"pub-id\">" +
        "<metadata xmlns:dc=\"http://purl.org/dc/elements/1.1/\">" +
        "<dc:title id=\"title\">VinXML</dc:title>" +
        "<dc:creator id=\"creator\">Maurice C Parker</dc:creator>" +
        "</metadata>" +
        "</package>"
        
        let doc = try VinXML.XMLDocument(xml: xml)
        doc?.registerXPathNamespace(prefix: "dc", url: "http://purl.org/dc/elements/1.1/")
        
        let dcTitle = try doc?.queryFirst(xpath: "//*/dc:title")
        XCTAssertNotNil(dcTitle?.content)
        XCTAssertEqual("VinXML", dcTitle!.content!)
        
        let dcCreator = try doc?.queryFirst(xpath: "//*/dc:creator")
        XCTAssertNotNil(dcCreator?.content)
        XCTAssertEqual("Maurice C Parker", dcCreator!.content!)
        
    }
    
}
