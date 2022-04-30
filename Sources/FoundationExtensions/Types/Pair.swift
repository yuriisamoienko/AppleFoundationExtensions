//
//  Pair.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 01.04.2021.
//

open class Pair<A, B> {
    public let first: A
    public let second: B
    
    required public init(first: A, second: B) {
        self.first = first
        self.second = second
    }
    
    public func reversed() -> Pair<B, A> {
        let result = Pair<B, A>(first: self.second, second: self.first)
        return result
    }
}
extension Pair: Equatable where A: Equatable, B: Equatable {
    public static func == (lhs: Pair<A, B>, rhs: Pair<A, B>) -> Bool {
        let result = lhs.first == rhs.first && lhs.second == rhs.second
        return result
    }
}

extension Pair where A == B, A: Equatable {
    public func contains(_ item: Pair<A, B>) -> Bool {
        var result = false
        if item == self {
            result = true
        } else if item.first == self.second,
                  item.second == self.first {
            result = true
        }
        return result
    }
    
    public func notContainsOneValue(from item: Pair<A, B>) -> Bool {
        var result = false
        if item.first != self.first,
           item.first != self.second
        {
            result = true
        } else if item.second != self.first,
                  item.second != self.second
        {
            result = true
        }
        
        
        return result
    }
    
    public func containsOneValue(from item: Pair<A, B>) -> Bool {
        let result = item.first == self.first
            || item.second == self.first
            || item.first == self.second
            || item.second == self.second
        
        return result
    }
    
    public func contains(_ item: A) -> Bool {
        var result = false
        if item == self.second {
            result = true
        } else if item == self.first {
            result = true
        }
        return result
    }

}
