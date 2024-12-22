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

// MARK: User facing card in Function Drawer

struct FunctionItemView: View {
    @State var function: Function
    @State var showSheet: Bool = false
    var body: some View {
        HStack {
            Text(function.name)
            
            Spacer()
            
            symbol(function.icon)
        }.padding()
            .padding(3.5)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primary.opacity(0.05), lineWidth: 1.8)
                    .fill(Color.secondary.opacity(0.2))
            )
            .padding(.top)
            .onTapGesture {
                showSheet = true
            }
            .sheet(isPresented: $showSheet) {
                self.function.sheet
            }
    }
}
