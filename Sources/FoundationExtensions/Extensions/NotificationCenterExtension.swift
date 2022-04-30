//
//  NotificationCenterExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 07.07.2021.
//

import Foundation

public extension NotificationCenter {
    
    @discardableResult
    func addObserver(forName name: NSNotification.Name?, using block: @escaping (Notification) -> Void) -> NSObjectProtocol {
        return addObserver(forName: name, object: nil, queue: nil, using: block)
    }
    
}
