//
//  NSBool.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 21.05.2021.
//

import Foundation

@objc
public class NSBool: NSObject {

    // MARK: Private properties
    private var value: Bool = false
    
    // MARK: Public properties
    @objc
    public var isTrue: Bool {
        return value == true
    }
    
    @objc
    public var isFalse: Bool {
        return value == false
    }
    
    // MARK: Public functions
    
    init(value: Bool) {
        super.init()
        self.value = value
    }
}
