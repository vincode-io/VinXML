//
//  Created by Maurice Parker on 3/4/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//

import libxml2

extension String {
    
    var xmlChars: [xmlChar] {
        get {
            return utf8CString.map { xmlChar($0) }
        }
    }
    
    func trim() -> String? {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.characters.count < 1 {
            return nil
        }
        return trimmed
    }
    
    func trimDownAllWhitespaces() -> String? {
        let result = components(separatedBy: .whitespacesAndNewlines)
            .filter({ return $0.characters.count > 0 })
            .joined(separator: " ")
        return result.trim()
    }
    
}
