//
//  ArrayExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 17.03.2021.
//

import Foundation

public extension Array {
    
    var isNotEmpty: Bool {
        get {
            return isEmpty == false
        }
    }
    
    mutating func move(from oldIndex: Index, to newIndex: Index) {
        // Don't work for free and use swap when indices are next to each other - this
        // won't rebuild array and will be super efficient.
        if oldIndex == newIndex { return }
        if abs(newIndex - oldIndex) == 1 { return self.swapAt(oldIndex, newIndex) }
        self.insert(self.remove(at: oldIndex), at: newIndex)
    }

    
    func forEach(exceptIndex: Int, _ body: (Element) -> Void) {
        for (index, item) in self.enumerated() {
            if index == exceptIndex {
                continue
            }
            body(item)
        }
    }
    
    
    mutating func appendItems(_ elements: Element...) {
        elements.forEach {
            self.append($0)
        }
    }
    
    @discardableResult
    mutating func append(optional: Element?) -> Self {
        if let value = optional {
            append(value)
        }
        return self
    }
    
    @discardableResult
    mutating func append(optionals: [Element?]) -> Self {
        for optional in optionals {
            if let value = optional {
                append(value)
            }
        }
        return self
    }
    
    func element(at index: Int) -> Element? {
        guard index >= 0,
              index < self.count
        else {
            return nil
        }
        return self[index]
    }
    
}

public extension Array where Element: Equatable {
    
    func substracting(_ array: Self) -> Self {
        let result = self.filter { !array.contains($0) }
        return result
    }
    
    func forEach(except: Element, _ body: (Element) -> Void) {
        let index = self.firstIndex(of: except) ?? -1
        forEach(exceptIndex: index, body)
    }

    func before(item: Element) -> Element? {
        guard self.count > 1,
              self.first != item
        else {
            return nil
        }
        var result: Element? = nil
        for index in 1..<self.count {
            let currentItem = self[index]
            guard currentItem == item else {
                continue
            }
            result = self[index - 1]
        }
        return result
    }

    static func -=(lhs: inout Array, rhs: Array) {
        rhs.forEach {
            if let indexOfhit = lhs.firstIndex(of: $0) {
                lhs.remove(at: indexOfhit)
            }
        }
    }
    
    static func -(lhs: Array, rhs: Array) -> Array {
        return lhs.filter { return !rhs.contains($0) }
    }
    
    mutating func move(_ element: Element, to newIndex: Index) {
        if let oldIndex: Int = self.firstIndex(of: element) {
            self.move(from: oldIndex, to: newIndex)
        }
    }
    
    mutating func swaptItems(_ first: Element, _ second: Element) {
        if let firstIndex = self.firstIndex(of: first),
           let secondIndex =  self.firstIndex(of: second)
        {
            swapAt(firstIndex, secondIndex)
        }
    }
    
    mutating func swap(item: Element, withIndex secondIndex: Int) {
        if secondIndex >= 0,
           secondIndex < count,
           let firstIndex = self.firstIndex(of: item)
        {
            swapAt(firstIndex, secondIndex)
        }
    }

    
    func contains(array: [Element]) -> Bool {
        var result = true
        for item in array {
            if self.contains(item) == false {
                result = false
                break
            }
        }
        return result
    }
    
    mutating func remove(elements: [Element]) {
        self = self.filter { elements.contains($0) == false }
    }

    // return true if element was found and deleted
    @discardableResult
    mutating func remove(_ element: Element) -> Bool {
        guard self.contains(element) == true else { return false}
        self = self.filter {$0 != element}
        return true
    }
  
    func shiftedRight(by element: Element) -> Self {
        guard let index = self.firstIndex(of: element),
              index > 0
        else {
            return self
        }
        let result = Array(self[index ..< count] + self[0 ..< index])
        return result
    }
    
    typealias PairElements = Pair<Element, Element>
    
    func pairs() -> [PairElements] {
        var result = [PairElements]()
        if count < 2 {
            return result
        } else if count == 2 {
            let pair = PairElements(first: self[0], second: self[1])
            return [pair, pair.reversed()]
        }
        for i in 0 ..< (count - 1) {
            for j in (i + 1) ..< count {
                let first = self[i]
                let second = self[j]
                result.append(Pair(first: first, second: second))
            }
        }
        return result
    }
    
    func randomPairs() -> [PairElements] {
        var pairArray = pairs().shuffled()
        guard pairArray.count > 2,
              var lastAppendResultItem = pairArray.popLast()
        else {
            return pairArray
        }
        var result: [PairElements] = [lastAppendResultItem]
        while pairArray.count > 1 {
            
            var didInsert = false
            
            if didInsert == false {
                for pair in pairArray {
                    if lastAppendResultItem.containsOneValue(from: pair) == true {
                        continue
                    }
                    
                    var contains = false
                    for resultItem in result {
//                        print("resultItem: first \(resultItem.first) second \(resultItem.second)")
//                        print("pair: first \(pair.first) second \(pair.second)")
                        if resultItem.contains(pair) == true {
                            contains = true
                            break
                        }
                    }
                    if contains == false {
                        result.append(pair)
                        pairArray.remove(pair)
                        didInsert = true
                        break
                    }
                }
            }
            
            if didInsert == false {
                for pair in pairArray {
                    var contains = false
                    for resultItem in result {
//                        print("resultItem: first \(resultItem.first) second \(resultItem.second)")
//                        print("pair: first \(pair.first) second \(pair.second)")
                        if resultItem.contains(pair) == true {
                            contains = true
                            break
                        }
                    }
                    if contains == false {
                        result.append(pair)
                        pairArray.remove(pair)
                        didInsert = true
                        break
                    }
                }
            }
            
            if didInsert == false {
                for pair in pairArray {
                    var contains = false
                    for resultItem in result {
//                        print("resultItem: first \(resultItem.first) second \(resultItem.second)")
//                        print("pair: first \(pair.first) second \(pair.second)")
                        if resultItem.containsOneValue(from: pair) == true {
                            contains = true
                            break
                        }
                    }
                    if contains == false {
                        result.append(pair)
                        pairArray.remove(pair)
                        didInsert = true
                        break
                    }
                }
            }
            
            if didInsert == false {
                for pair in pairArray {
                    for resultItem in result.reversed() {
//                        print("resultItem: first \(resultItem.first) second \(resultItem.second)")
//                        print("pair: first \(pair.first) second \(pair.second)")
                        if resultItem.notContainsOneValue(from: pair) == true {
                            result.append(pair)
                            pairArray.remove(pair)
                            didInsert = true
                            break
                        }
                    }
                }
            }
            if didInsert == true,
               let last = result.last
            {
                lastAppendResultItem = last
            }
            if didInsert == false {
                fatalErrorEx("whyyy?????")
                break
            }
        }
        if let last = pairArray.popLast() {
            result.append(last)
        }
        
        return result
    }
}
