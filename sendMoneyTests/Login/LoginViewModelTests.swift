//
//  sendMoneyTests.swift
//  sendMoneyTests
//
//  Created by Ahmed Ezz on 19/01/2025.
//

import XCTest
@testable import sendMoney

final class LoginViewModelTests: XCTestCase {
    
    private var viewModel: LoginViewModel!
    private let mockEmail = "mockUser"
    private let mockPassword = "123456"
    private let loginErrorMessage = UIStrings.generalErrorMessage.localized

    override func setUpWithError() throws {
        let currentUser = UserModel(email: "mockUser", password: "123456")
        viewModel = LoginViewModel(currentUser: currentUser, loginErrorMessage: loginErrorMessage)
    }
    
    //MARK: - Login_onUserEmailIsNotValid_onFailureClosureIsCalled
    func test_login_onUserEmailIsNotValid_onFailureClosureIsCalled() {
        // Given
        let email = "testUser"
        var errorMessage = ""
        var isFailureClosureIsCalled = false
        // When
        viewModel.signIn(user: .init(email: email, password: mockPassword), onComplete: { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                isFailureClosureIsCalled = true
                errorMessage = error.localizedDescription
            }
        })
        // Then
        XCTAssertTrue(isFailureClosureIsCalled)
        XCTAssertEqual(errorMessage, loginErrorMessage)
    }
    
    //MARK: - Login_onPasswordIsNotValid_onFailureClosureIsCalled
    func test_login_onPasswordIsNotValid_onFailureClosureIsCalled() {
        // Given
        let password = "password123"
        var errorMessage = ""
        var isFailureClosureIsCalled = false
        // When
        viewModel.signIn(user: .init(email: mockEmail, password: password), onComplete: { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                isFailureClosureIsCalled = true
                errorMessage = error.localizedDescription
            }
        })
        // Then
        XCTAssertTrue(isFailureClosureIsCalled)
        XCTAssertEqual(errorMessage, loginErrorMessage)
    }
    
    //MARK: - Login_onDataValid_onSuccessClosureIsCalled
    func test_login_onDataValid_onSuccessClosureIsCalled() {
        // Given
        var isSuccessClosureIsCalled = false
        // When
        viewModel.signIn(user: .init(email: mockEmail, password: mockPassword), onComplete: { result in
            switch result {
            case .success:
                isSuccessClosureIsCalled = true
            case .failure:
                break
            }
        })
        // Then
        XCTAssertTrue(isSuccessClosureIsCalled)
    }
}
