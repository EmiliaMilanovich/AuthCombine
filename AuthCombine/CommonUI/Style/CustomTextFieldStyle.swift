//
//  CustomTextFieldStyle.swift
//  AuthCombine
//
//  Created by Эмилия on 08.04.2024.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
          return configuration
                .textFieldStyle(.plain)
                .padding(.horizontal, 8)
                .frame(height: 45)
                .cornerRadius(10)
                .foregroundColor(.white)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
        }
}
