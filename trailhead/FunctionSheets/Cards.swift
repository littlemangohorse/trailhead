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
    @Bindable var object: Object
    @State var user: User
    @Query var objects: [Object]
    @State var displayEditSheet: Bool = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VortexViewReader { proxy in
            HStack {
                
                VStack(alignment: .leading) {
                    
//                    Text(object.date.formatted(.dateTime.weekday(.abbreviated).month(.abbreviated).day())).textCase(.uppercase)
                    Text(object.date.formatted(.dateTime.hour().minute())).textCase(.uppercase)
                        .font(.caption)
                    Text(object.name)
                        .font(.headline)
                    
                }
                .padding(.leading)
                .padding(.vertical, 5)
                .onTapGesture {
                    self.displayEditSheet.toggle()
                }
                
                Spacer()
                
                switch object.type {
                case .task:
                    taskButtons
                case .event:
                    symbol("calendar")
                case .habit:
                    symbol("point.forward.to.point.capsulepath.fill")
                case .unknown:
                    symbol("questionmark")
                }
            }
            .padding(3.5)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(object.completed ? Color.green.opacity(0.2) : Color.primary.opacity(0.2), lineWidth: 1.8)
                    .fill(Color.secondary.opacity(0.2))
            )
            .id(object.id)
            .contextMenu {
                Text(object.details)
                
                Button {
                    print("Remove")
                    modelContext.delete(object)
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
                EditTaskSheet(object: object)
            }
        }
    }
    
    var taskButtons: some View {
        VortexViewReader { proxy in
            Group {
                if object.completed {
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
                    object.completed.toggle()
                }
            }
            .sensoryFeedback(.selection, trigger: object.completed)
            .padding(.trailing)
        }
    }
    
}
