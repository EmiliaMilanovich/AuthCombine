//
//  ContentView.swift
//  AuthCombine
//
//  Created by Эмилия on 08.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    private let screen = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.dark
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 35) {
                    
                    Image("boy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screen/1.25, height: screen/1.25)
                    
                    Text("Авторизация")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .padding(8)
                    
                    VStack(spacing: 20) {
                        CustomTextField(title: "Email", text: $viewModel.email, prompt: viewModel.emailPrompt)
                        CustomTextField(title: "Номер телефона", text: $viewModel.phone, prompt: viewModel.phonePrompt)
                            .onChange(of: viewModel.phone) { _ in
                                DispatchQueue.main.async {
                                    viewModel.phone = viewModel.phone.formattedMask(text: viewModel.phone, mask: "+X (XXX) XXX-XX-XX")
                                }
                            }
                        CustomTextField(title: "Пароль", text: $viewModel.password, prompt: viewModel.passwordPrompt, isSecure: true)
                    }
                    .padding(.horizontal)
                                        
                    Button {} label: {
                        ZStack {
                            if viewModel.canSubmit {
                                AnimatedGradient(colors: [.purple, .cyan])
                            } else {
                                Rectangle()
                                    .foregroundColor(.gray)
                            }
                            Text("Login")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .fontDesign(.rounded)
                        }
                        .cornerRadius(12)
                        .frame(width: 150, height: 45)
                    }
                    .disabled(viewModel.canSubmit)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
