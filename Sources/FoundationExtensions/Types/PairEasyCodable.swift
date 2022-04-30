//
//  PairEasyCodable.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 01.04.2021.
//

import Foundation

open class PairEasyCodable<A: EasyCodable, B: EasyCodable>: Pair<A, B>, EasyCodable {
    
    // MARK: - Decodable
    
    // All your properties should be included
    private enum CodingKeys: String, CodingKey {
        case first
        case second
    }

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let first = try values.decode(A.self, forKey: .first)
        let second = try values.decode(B.self, forKey: .second)
        super.init(first: first, second: second)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(first, forKey: .first)
        try container.encode(second, forKey: .second)
    }
    
    required public init(first: A, second: B) {
        super.init(first: first, second: second)
    }
}
