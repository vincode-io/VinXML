//
//  XMLDoc.swift
//  VinFoundation
//
//  Created by Maurice Parker on 1/30/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//

import Foundation

// TODO: See how xmllib2 uses the node type and see if it is really subclassable
public protocol XMLNode {
    
    var name: String? { get set }
    var content: String? { get }
    
}
