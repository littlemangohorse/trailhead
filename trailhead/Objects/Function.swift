//
//  FunctionItem.swift
//  trailhead
//
//  Created by Matthew Smith on 12/21/24.
//

import Foundation
import SwiftUI

// MARK: Function objects store data relevant to their specific function. They display sheets relative to their specified function.

@Observable
class Function: Identifiable {
    let id: UUID
    let name: String
    let icon: String
    let sheet: AnyView
    
    init(id: UUID, name: String, icon: String, sheet: AnyView) {
        self.id = id
        self.name = name
        self.icon = icon
        self.sheet = sheet
    }
}
