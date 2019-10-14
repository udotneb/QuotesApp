//
//  ExtensionsBackend.swift
//  Affirm
//
//  Created by Benjamin Ulrich on 10/14/19.
//  Copyright © 2019 Benjamin Ulrich. All rights reserved.
//

import Foundation

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
    func substringAtEnd(substring: String) -> Bool {
        if self.count - substring.count >= 0 {
            for i in 0..<substring.count {
                if self[self.count - (substring.count - i)] != substring[i] {
                    return false
                }
            }
            return true
        }
        return false
    }
    func slices(from: String, to: String) -> [String]? {
        var currString = ""
        var currentlyWriting = false  // 0 havent seen from, 1 have seen currstring
        var matchedStrings: [String] = []
        
        for letter in self {
            currString = currString + String(letter)
            
            let containsFrom = currString.substringAtEnd(substring: from)
            let containsTo = currString.substringAtEnd(substring: to)
            
            if containsFrom {
                currentlyWriting = true
                currString = ""
            }
            
            if !currentlyWriting && currString.count >= 2 * from.count {
                // dont let currString get too large
                let startIndex = currString.index(currString.startIndex, offsetBy: from.count)
                currString = String(currString[startIndex...])
            }
            
            if containsTo && currentlyWriting {
                let removeEnd = currString.replacingOccurrences(of: to, with: "")
                if removeEnd.count > 0 { //there is a string between from and to
                    let cleanedApostrophe = removeEnd.replacingOccurrences(of: "&#39;", with: "'")
                    matchedStrings.append(cleanedApostrophe)
                }
                currString = ""
                currentlyWriting = false
            }
        }
        return matchedStrings
    }
}


