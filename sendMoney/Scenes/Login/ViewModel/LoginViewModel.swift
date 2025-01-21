//
//  LoginViewModel.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 19/01/2025.
//


class LoginViewModel {
    private let currentUser: UserModel
    private let loginErrorMessage: String
    
    init(currentUser: UserModel, loginErrorMessage: String) {
        self.currentUser = currentUser
        self.loginErrorMessage = loginErrorMessage
    }
    
    func signIn(user: UserModel, onComplete: ((Result<Bool, CustomError>)-> Void)) {
        guard currentUser.email == user.email, currentUser.password == user.password else {
            onComplete(.failure(.custom(loginErrorMessage)))
            return
        }
        onComplete(.success(true))
    }
}
