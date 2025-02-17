//
//  NewTaskEditSheet.swift
//  trailhead
//
//  Created by Matthew Smith on 12/22/24.
//

import SwiftUI
import SwiftData

struct NewTaskEditSheet: View {
    @Query var tasks: [Object]
    @State var title: String = ""
    @State var details: String = ""
    @State var recurring: Bool = false
    @State var date: Date = Date()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        let newTask = Object(id: UUID(), eventIdString: nil, type: .task, name: title, completed: false, details: details, date: date)
        
        ScrollView {
            VStack {
                TextField(text: $title, label: { Text("Title") })
                    .basicStyle()
                TextField(text: $details, label: { Text("Details") })
                    .basicStyle()
                Toggle(isOn: $recurring) { Text("Recurring").foregroundStyle(.secondary) }
                    .basicStyle()
                
                DatePicker("Select a date", selection: $date)
                    .datePickerStyle(.graphical)
                
                
                
                Spacer()
                
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .basicStyle()
                    }.padding(.bottom)
                    .buttonStyle(.plain)
                    
                    Button {
                        modelContext.insert(newTask)
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                            .basicStyle()
                    }.padding(.bottom)
                    .buttonStyle(.plain)
                }

            }

        }
    }
}

