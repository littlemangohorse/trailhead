//
//  UserNameEditSheet.swift
//  trailhead
//
//  Created by Matthew Smith on 12/21/24.
//

import SwiftUI

struct UserNameEditSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @Bindable var user: User
    
    var body: some View {
        VStack {
            TextField("Your name", text: $user.name)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary.opacity(0.05), lineWidth: 1.8)
                        .fill(Color.secondary.opacity(0.2))
                )
                .padding(.horizontal)
                .padding(.top)
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.primary.opacity(0.05), lineWidth: 1.8)
                            .fill(Color.secondary.opacity(0.2))
                    )
                    .padding()
            }.buttonStyle(PlainButtonStyle())

        }
    }
}

#Preview {
    UserNameEditSheet(user: basicUser)
}
