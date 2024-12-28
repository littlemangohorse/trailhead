//
//  EditTaskSheet.swift
//  trailhead
//
//  Created by Matthew Smith on 12/27/24.
//

import SwiftUI
import SwiftData

struct EditTaskSheet: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Bindable var task: Task
    
    var body: some View {
        VStack {
            Text("Edit \(task.title)")
                .font(.title3)
            
            TextField("Title", text: $task.title)
                .basicStyle()
            TextField("Description", text: $task.details)
                .basicStyle()
            Toggle("Completed", isOn: $task.completed)
                .basicStyle()
            
//            DatePicker("Select a date", selection: $task.dueDate)
//                .datePickerStyle(.graphical)
            
            Spacer()
        }.padding(.vertical)
    }
}
