//
//  Item.swift
//  snmpeasy
//
//  Created by Simon Lewis on 11/28/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
