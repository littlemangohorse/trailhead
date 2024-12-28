//
//  ActionDrawer.swift
//  trailhead
//
//  Created by Matthew Smith on 12/21/24.
//

import SwiftUI
import SwiftData
import Glossy

struct FunctionDrawer: View {
    @Binding var selectedDetent: PresentationDetent
    @State private var searchText: String = ""
    @State var user: User
    @Query var tasks: [Task]
    @State var functions: [Function]
    
    init(selectedDetent: Binding<PresentationDetent>, user: User, functions: [Function]) {
        _selectedDetent = selectedDetent
        self.user = user
        self.functions = [
            Function(id: UUID(), name: "Name Edit", icon: "pencil", sheet: AnyView(UserNameEditSheet(user: user))),
            Function(id: UUID(), name: "New Task", icon: "plus", sheet: AnyView(NewTaskEditSheet())),
        ]
    }
}

extension FunctionDrawer {
    var body: some View {
        VStack {
            TextField("Search an action, setting, or item", text: $searchText, onEditingChanged: { editing in
                if editing {
                    self.selectedDetent = .large
                }
            })
                .basicStyle()
                .onSubmit {
                    if self.searchText.isEmpty {
                        self.selectedDetent = .height(100)
                    }
                }
            
            VStack {
                List {
                    
                    ForEach(self.tasks.filter{$0.title.lowercased().contains(searchText.lowercased()) || searchText == ""}, id: \.id) { task in
                        ObjectCard(task: task, user: self.user)
                    }.listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                
                    
                    
                    ForEach(self.functions.filter{$0.name.lowercased().contains(searchText.lowercased()) || searchText == ""}, id: \.id) { function in
                        FunctionItemView(function: function)
                    }.listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                }.listStyle(.plain)
                    .background(Color.clear)
            }.blur(radius: self.selectedDetent == .height(100) ? 20 : 0)
        }
    }
}

#Preview {
    @Previewable @State var selectedDetent: PresentationDetent = .height(100)
    FunctionDrawer(selectedDetent: $selectedDetent, user: basicUser, functions: [])
}
