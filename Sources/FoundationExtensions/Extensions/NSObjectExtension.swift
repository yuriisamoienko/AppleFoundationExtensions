//
//  NSObjectExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 16.03.2021.
//

import Foundation

public extension NSObject {
    func className() -> String {
        let result = String(describing: type(of: self))
        return result
    }
    
    /* Not working because of Self as closure param type
     @discardableResult
    func setupMe(_ closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }*/
}


@objc
public extension NSObject {
    
    func debounse(delay: Double, closure: @escaping() -> Void) {
        debounse(queue: .main, delay: delay, closure: closure)
    }
    
    func debounse(queue: DispatchQueue, delay: Double, closure: @escaping() -> Void) {
        debounce(queue: queue, delay: delay, closure: closure)
    }
    
    @objc(makeReferenceToChild:)
    func makeReferenceTo(child: NSObject) {
        let container: NSObjectArrayContainer = referencesMap.object(forKey: self) ?? {
            let result = NSObjectArrayContainer([])
            referencesMap.setObject(result, forKey: self)
            return result
        }()
        container.content.append(child)
    }
}

fileprivate let referencesMap = NSMapTable<NSObject, NSObjectArrayContainer>(keyOptions: .weakMemory, valueOptions: .strongMemory)

fileprivate class NSObjectArrayContainer: StrongContainer<[NSObject]> {}
