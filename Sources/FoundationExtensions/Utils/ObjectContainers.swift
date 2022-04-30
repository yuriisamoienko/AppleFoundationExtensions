//
//  ObjectContainers.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 20.05.2021.
//

import Foundation

public class StrongContainer<T>: NSObject {
    public var content: T
    private var onDeinit: ((T) -> Void)?
    
    public init(_ value: T, onDeinit: ((T) -> Void)? = nil) {
        self.content = value
        self.onDeinit = onDeinit
        super.init()
    }
    
    deinit {
        printFuncLog("deinit \(ObjectIdentifier(self))")
        onDeinit?(content)
    }
}

public class WeakContainer<T: AnyObject>: NSObject {
    public weak var content: T!
    private var onDeinit: ((T) -> Void)?
    
    public init(_ value: T, onDeinit: ((T) -> Void)? = nil) {
        self.content = value
        self.onDeinit = onDeinit
        super.init()
    }
    
    deinit {
        onDeinit?(content)
    }
}
