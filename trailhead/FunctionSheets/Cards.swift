//
//  TaskViews.swift
//  trailhead
//
//  Created by Matthew Smith on 12/22/24.
//

import SwiftUI
import SwiftData
import Vortex

struct ObjectCard: View {
    @Bindable var task: Task
    @State var user: User
    @Query var tasks: [Task]
    @State var displayEditSheet: Bool = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VortexViewReader { proxy in
            HStack {
                Text(task.title)
                    .font(.headline)
                    .padding()
                    .onTapGesture {
                        self.displayEditSheet.toggle()
                    }
                
                Spacer()
                
                Group {
                    if task.completed {
                        ZStack {
                            VortexView(.magic) {
                                Circle()
                                    .fill(.green)
                                    .blendMode(.plusLighter)
                                    .tag("sparkle")
                                    .opacity(0.03)
                            }
                            symbol("checkmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                        }.frame(width: 45, height: 45, alignment: .trailing)
                    } else {
                        symbol("checkmark.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24, alignment: .trailing)
                    }
                }.onTapGesture { location in
                    withAnimation {
                        proxy.attractTo(location)
                        proxy.burst()
                        task.completed.toggle()
                    }
                }
                .sensoryFeedback(.selection, trigger: task.completed)
                .padding(.trailing)
            }
            .padding(3.5)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(task.completed ? Color.green.opacity(0.2) : Color.primary.opacity(0.2), lineWidth: 1.8)
                    .fill(Color.secondary.opacity(0.2))
            )
            .id(task.id)
            .contextMenu {
                Text(task.details)
                
                Button {
                    print("Remove")
                    modelContext.delete(task)
                } label: {
                    Label("Delete", systemImage: "minus.circle")
                }
                
                Button {
                    print("Edit")
                    self.displayEditSheet.toggle()
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
            }
            .sheet(isPresented: $displayEditSheet) {
                EditTaskSheet(task: self.task)
            }
        }
    }
}
