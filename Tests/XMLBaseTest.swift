//
//  XMLLib2BaseTest.swift
//  VinFoundation
//
//  Created by Maurice Parker on 2/4/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//

import XCTest
@testable import VinXML

class XMLBaseTest: XCTestCase {

    static var bundle: Bundle {
        return Bundle(for: XMLBaseTest.self)
    }
    
    let testHTML = "<html><head><title>Title</title></head><body>"
        + "<h1>A heading 1 title<h1>"
        + "<p id=\"first\">The first paragraph."
        + "  <div id=\"p1div1\">Div block 1</div>"
        + "  <div id=\"p1div2\">Div block 2</div>"
        + "  <div id=\"p1div3\">Div block 3</div>"
        + "</p>"
        + "<p id=\"second\">The second paragraph.</p>"
        + "<p id=\"third\">The third paragraph."
        + "  <div id=\"p3div1\">Div block 1</div>"
        + "  <div id=\"p3div2\">Div block 2</div>"
        + "  <div id=\"p3div3\">Div block 3</div>"
        + "</p>"
        + "</body></html>"
    
    func loadHTHLDoc() throws -> XMLDoc {
        let htmlLocation = XMLBaseTest.bundle.url(forResource: "vincode.io", withExtension: "html")
        guard let html = try? String(contentsOf: htmlLocation!) else {
            fatalError()
        }
        return try XMLDoc(html: html)
    }
    
}
