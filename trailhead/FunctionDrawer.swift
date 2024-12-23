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
    @State var isFullScreen: Bool
    
    init(searchText: String, user: User, functions: [Function], isFullScreen: Bool) {
        self.searchText = searchText
        self.user = user
        self.functions = [
            Function(id: UUID(), name: "Name Edit", icon: "pencil", sheet: AnyView(UserNameEditSheet(user: user))),
            Function(id: UUID(), name: "New Task", icon: "plus", sheet: AnyView(NewTaskEditSheet(user: user))),
        ]
        self.isFullScreen = isFullScreen
    }
}

extension FunctionDrawer {
    var body: some View {
        VStack {
            TextField("Search an action, setting, or item", text: $searchText, onEditingChanged: { editing in
                if editing {
                    self.isFullScreen = true
                }
            })
                .basicStyle()
                .onSubmit {
                    self.isFullScreen = false
                }
                
            
            List {
                if self.isFullScreen {
                    ForEach(self.functions, id: \.id) { function in
                        FunctionItemView(function: function)
                    }.listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
            }.listStyle(.plain)
        }
    }
}

#Preview {
    FunctionDrawer(searchText: "", user: basicUser, functions: [], isFullScreen: true)
}
