//
//  VisitorHost.swift
//  VinFoundation
//
//  Created by Maurice Parker on 2/14/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//

import Foundation

public protocol XMLVisitorHost {
    
    func host(visitor: XMLVisitor) throws
    
}
