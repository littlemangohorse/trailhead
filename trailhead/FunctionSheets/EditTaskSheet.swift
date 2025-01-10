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
    
    @Bindable var object: Object
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Edit \(object.name)")
                    .font(.title3)
                
                TextField("Title", text: $object.name)
                    .basicStyle()
                TextField("Description", text: $object.details)
                    .basicStyle()
                Toggle("Completed", isOn: $object.completed)
                    .basicStyle()
                
                DatePicker("Select a date", selection: $object.date)
                    .datePickerStyle(.graphical)
                
                Spacer()
            }.padding(.vertical)
        }
    }
}
