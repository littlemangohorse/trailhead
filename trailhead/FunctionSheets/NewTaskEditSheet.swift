//
//  NewTaskEditSheet.swift
//  trailhead
//
//  Created by Matthew Smith on 12/22/24.
//

import SwiftUI
import SwiftData

struct NewTaskEditSheet: View {
    @Bindable var user: User
    @State var title: String = ""
    @State var details: String = ""
    @State var recurring: Bool = false
    var body: some View {
        let newTask = Task(id: UUID(), title: title, details: details, completed: false, recurring: recurring)
        
        VStack {
            TextField(text: $title, label: { Text("Title") })
                .basicStyle()
            TextField(text: $details, label: { Text("Details") })
                .basicStyle()
            Toggle(isOn: $recurring) { Text("Recurring") }
            
            Spacer()
            
            Button {
                print("Save logic")
                user.tasks.append(newTask)
            } label: {
                Text("Save")
                    .basicStyle()
            }.padding(.bottom)

        }
        
    }
}

