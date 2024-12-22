//
//  UserNameEditSheet.swift
//  trailhead
//
//  Created by Matthew Smith on 12/21/24.
//

import SwiftUI

struct UserNameEditSheet: View {
    @Bindable var user: User
    
    var body: some View {
        TextField("Your name", text: $user.name)
    }
}

#Preview {
    UserNameEditSheet(user: basicUser)
}
