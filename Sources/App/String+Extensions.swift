//
//  String+Extensions.swift
//  Palindromix
//
//  Created by Shahin on 2017-01-23.
//
//

import Foundation

extension String
{
    var lettersOnly: String
    {
        return components(separatedBy: NSCharacterSet.letters.inverted).joined(separator: "")
    }
    
    var isPalindromic: Bool
    {
        return String(characters.reversed()).lettersOnly.lowercased() == lettersOnly.lowercased()
    }
}
