//
//  XMLXPath.swift
//  VinFoundation
//
//  Created by Maurice Parker on 2/10/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//

import Foundation
import libxml2

protocol XMLXPath {

    func query(xpath: String) throws -> [XMLElement]
    func queryFirst(xpath: String) throws -> XMLElement?
    func remove(xpath: String) throws

}

extension XMLXPath {
    
    public func queryFirst(xpath: String) throws -> XMLElement? {
        let results = try self.query(xpath: xpath)
        guard results.count > 0 else {
            return nil
        }
        return results[0]
    }
    
    public func remove(xpath: String) throws {
        
        let results = try self.query(xpath: xpath)
        try results.forEach() { xmlElement in
            try xmlElement.remove()
        }
        
    }
    
}
