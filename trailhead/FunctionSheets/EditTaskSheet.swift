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
        Form {
            TextField("Title", text: $task.title)
            TextField("Description", text: $task.details)
            Toggle("Completed", isOn: $task.completed)
        }
    }
}
