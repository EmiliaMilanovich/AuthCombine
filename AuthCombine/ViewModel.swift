//
//  ViewModel.swift
//  AuthCombine
//
//  Created by Эмилия on 08.04.2024.
//

import Foundation
import Combine

final class ViewModel: ObservableObject {
    @Published var email = ""
    @Published var phone = ""
    @Published var password = ""
    @Published var canSubmit = false
    
    var emailPrompt: String? {
        if email.isEmpty || isValidEmail == true {
            return nil
        } else {
            return "Неверный формат. Пример: text@test.com"
        }
    }
    
    var phonePrompt: String? {
        if phone.isEmpty || isValidPhone == true {
            return nil
        } else {
            return "Неверный формат."
        }
    }
    
    var passwordPrompt: String? {
        if password.isEmpty || isValidPassword == true {
            return nil
        } else {
            return "Пароль должен быть не менее 8 символов"
        }
    }
    
    @Published private var isValidEmail = false
    @Published private var isValidPhone = false
    @Published private var isValidPassword = false

    
    private let emailPredicate = NSPredicate(format: "SELF MATCHES %@", Regex.email.rawValue)
    private let phonePredicate = NSPredicate(format: "SELF MATCHES %@", Regex.phone.rawValue)
    
    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        $email
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { email in
                self.emailPredicate.evaluate(with: email)
            }
            .assign(to: \.isValidEmail, on: self)
            .store(in: &cancellable)
        
        $phone
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { phone in
                self.phonePredicate.evaluate(with: phone)
            }
            .assign(to: \.isValidPhone, on: self)
            .store(in: &cancellable)
        
        $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { password in
                password.count >= 8
            }
            .assign(to: \.isValidPassword, on: self)
            .store(in: &cancellable)
        
        Publishers.CombineLatest3($isValidEmail, $isValidPhone, $isValidPassword)
            .map { email, phone, password in
                return (email && phone && password)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellable)
    }
}
