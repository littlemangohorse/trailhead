//
//  Custom Objects.swift
//  trailhead
//
//  Created by Matthew Smith on 12/22/24.
//

import SwiftUI
import SwiftData

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
            .onTapGesture {
                showSheet = true
            }
            .sheet(isPresented: $showSheet) {
                self.function.sheet
            }.presentationDetents([.height(300), .fraction(0.15)])
            .presentationDragIndicator(.automatic)
    }
}

extension TextField {
    func basicStyle() -> some View {
        self
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primary.opacity(0.05), lineWidth: 1.8)
                    .fill(Color.secondary.opacity(0.2))
            )
            .padding(.horizontal)
            .padding(.top)
    }
}

extension Text {
    func basicStyle() -> some View {
        self
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primary.opacity(0.05), lineWidth: 1.8)
                    .fill(Color.secondary.opacity(0.2))
                    .frame(maxWidth: .infinity)
            )
            .padding(.horizontal)
            .padding(.top)
    }
}

extension HStack {
    func basicStyle() -> some View {
        self
            .padding(3.5)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primary.opacity(0.05), lineWidth: 1.8)
                    .frame(maxWidth: .infinity)
            )
            .padding(.horizontal)
    }
}
