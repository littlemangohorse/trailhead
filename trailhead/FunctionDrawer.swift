//
//  ActionDrawer.swift
//  trailhead
//
//  Created by Matthew Smith on 12/21/24.
//

import SwiftUI

struct FunctionDrawer: View {
    @State private var searchText: String = ""
    @State var user: User
    @State var functions: [Function]
    
    init(searchText: String, user: User, functions: [Function]) {
        self.searchText = searchText
        self.user = user
        self.functions = [
            Function(id: UUID(), name: "Name Edit", icon: "pencil", sheet: AnyView(UserNameEditSheet(user: user)))
        ]
    }
}

extension FunctionDrawer {
    var body: some View {
        VStack {
            TextField("Search an action, setting, or item", text: $searchText)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary.opacity(0.05), lineWidth: 1.8)
                        .fill(Color.secondary.opacity(0.2))
                )
                .padding(.horizontal)
                .padding(.top)
            
            List {
                ForEach(self.functions, id: \.id) { function in
                    FunctionItemView(function: function)
                }.listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }.listStyle(.plain)
        }
    }
}

#Preview {
    FunctionDrawer(searchText: "", user: basicUser, functions: [])
}
