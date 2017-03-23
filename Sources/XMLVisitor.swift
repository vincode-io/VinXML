//
//  Visitor.swift
//  VinXML
//
//  Created by Maurice Parker on 2/14/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//

public protocol XMLVisitor {
    func visit(host: XMLVisitorHost) throws -> Bool
}
