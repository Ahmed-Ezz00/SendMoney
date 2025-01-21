//
//  SendMoneyViewModelTests.swift
//  sendMoneyTests
//
//  Created by Ahmed Ezz on 21/01/2025.
//

import XCTest
@testable import sendMoney

final class SendMoneyViewModelTests: XCTestCase {
    
    private var viewModel: SendMoneyViewModel!
    
    override func setUpWithError() throws {
        let coreDataManager = MockCoreDataManager()
        viewModel = SendMoneyViewModel(coreDataManager: coreDataManager)
    }
    
    //MARK: - FetchData_onResponseIsNotValid_onFailureClosureIsCalled
    func test_fetchData_onResponseIsNotValid_onFailureClosureIsCalled() {
        // Given
        var isFailureClosureIsCalled = false
        viewModel = SendMoneyViewModel(jsonModelFile: .none)
        // When
        viewModel.retrieveData { result in
            switch result {
            case .success:
                break
            case .failure:
                isFailureClosureIsCalled = true
            }
        }
        // Then
        XCTAssertTrue(isFailureClosureIsCalled)
    }
    
    //MARK: - FetchData_onResponseIsValid_onSuccessClosureIsCalled
    func test_fetchData_onResponseIsValid_onSuccessClosureIsCalled() {
        // Given
        var isSuccessClosureIsCalled = false
        var responseData: SendMoneyModel?
        viewModel = SendMoneyViewModel(jsonModelFile: .sendMoney)
        // When
        viewModel.retrieveData {[weak self] result in
            switch result {
            case .success:
                isSuccessClosureIsCalled = true
                responseData = self?.viewModel.jsonResponse
            case .failure:
                break
            }
        }
        // Then
        XCTAssertTrue(isSuccessClosureIsCalled)
        XCTAssertNotNil(responseData)
    }
    
    //MARK: - EnableButton_onServiceIsNotSelected_shouldDisableButton
    func test_enableButton_onServiceIsNotSelected_shouldDisableButton() {
        // Given
        var isButtonEnabled = true
        viewModel.jsonResponse = getMockJsonData()
        viewModel.selectedService = nil
        // When
        isButtonEnabled = viewModel.shouldEnableAction()
        // Then
        XCTAssertFalse(isButtonEnabled)
    }
    
    //MARK: - EnableButton_onProviderIsNotSelected_shouldDisableButton
    func test_enableButton_onProviderIsNotSelected_shouldDisableButton() {
        // Given
        var isButtonEnabled = true
        viewModel.jsonResponse = getMockJsonData()
        viewModel.selectedService = viewModel.jsonResponse?.services?.first
        viewModel.selectedProvider = nil
        // When
        isButtonEnabled = viewModel.shouldEnableAction()
        // Then
        XCTAssertFalse(isButtonEnabled)
    }
    
    //MARK: - EnableButton_onServiceProviderSelected_shouldEnableButton
    func test_enableButton_onServiceProviderSelected_shouldEnableButton() {
        // Given
        var isButtonEnabled = false
        viewModel.jsonResponse = getMockJsonData()
        viewModel.selectedService = viewModel.jsonResponse?.services?.first
        viewModel.selectedProvider = viewModel.selectedService?.providers?.first
        // When
        isButtonEnabled = viewModel.shouldEnableAction()
        // Then
        XCTAssertTrue(isButtonEnabled)
    }
    
    //MARK: - CheckValueValidation_onValueIsNil_shouldReturnFalse
    func test_checkValueValidation_onValueIsNil_shouldReturnFalse() {
        // Given
        let value: String? = nil
        var isValueValid = true
        // When
        isValueValid = viewModel.isValueValid(text: value, regex: nil)
        // Then
        XCTAssertFalse(isValueValid)
    }
    
    //MARK: - CheckValueValidation_onValueIsNotValid_shouldReturnFalse
    func test_checkValueValidation__onValueIsNotValid_shouldReturnFalse() {
        // Given
        let regex = "^(?:19|20)\\d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12]\\d|3[01])$"
        let value: String = "01/01/2020"
        var isValueValid = true
        // When
        isValueValid = viewModel.isValueValid(text: value, regex: regex)
        // Then
        XCTAssertFalse(isValueValid)
    }
    
    //MARK: - CheckValueValidation_onValueIsValid_shouldReturnTrue
    func test_checkValueValidation__onValueIsValid_shouldReturnTrue() {
        // Given
        let regex = "^(?:19|20)\\d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12]\\d|3[01])$"
        let value: String = "2020-01-01"
        var isValueValid = false
        // When
        isValueValid = viewModel.isValueValid(text: value, regex: regex)
        // Then
        XCTAssertTrue(isValueValid)
    }
    
    //MARK: - CanSaveRequest_onServiceIsNotSelected_shouldReturnFalse
    func test_canSaveRequest_onServiceIsNotSelected_shouldReturnFalse() {
        // Given
        var canSaveRequest = true
        let mockJsonData = getMockJsonData()
        let selectedProvider = mockJsonData?.services?.first?.providers?.first
        viewModel.jsonResponse = mockJsonData
        viewModel.selectedService = nil
        // When
        canSaveRequest = viewModel.canSaveRequest(values: getMockValidInputsData(provider: selectedProvider))
        // Then
        XCTAssertFalse(canSaveRequest)
    }
    
    //MARK: - CanSaveRequest_onProviderIsNotSelected_shouldReturnFalse
    func test_canSaveRequest_onProviderIsNotSelected_shouldReturnFalse() {
        // Given
        var canSaveRequest = true
        var selectedProvider: Provider? {
            return viewModel.selectedService?.providers?.first
        }
        viewModel.jsonResponse = getMockJsonData()
        viewModel.selectedService = viewModel.jsonResponse?.services?.first
        viewModel.selectedProvider = nil
        // When
        canSaveRequest = viewModel.canSaveRequest(values: getMockValidInputsData(provider: selectedProvider))
        // Then
        XCTAssertFalse(canSaveRequest)
    }
    
    //MARK: - CanSaveRequest_onProviderRquiredFieldsNotValid_shouldReturnFalse
    func test_canSaveRequest_onProviderRquiredFieldsNotValid_shouldReturnFalse() {
        // Given
        var canSaveRequest = true
        var selectedProvider: Provider? {
            return viewModel.selectedService?.providers?.first
        }
        viewModel.jsonResponse = getMockJsonData()
        viewModel.selectedService = viewModel.jsonResponse?.services?.first
        viewModel.selectedProvider = selectedProvider
        // When
        canSaveRequest = viewModel.canSaveRequest(values: getMockNotValidInputsData(provider: selectedProvider))
        // Then
        XCTAssertFalse(canSaveRequest)
    }
    
    //MARK: - CanSaveRequest_onProviderRquiredFieldValid_shouldReturnTrue
    func test_canSaveRequest_onProviderRquiredFieldsValid_shouldReturnTrue() {
        // Given
        var canSaveRequest = false
        var selectedProvider: Provider? {
            return viewModel.selectedService?.providers?.first
        }
        viewModel.jsonResponse = getMockJsonData()
        viewModel.selectedService = viewModel.jsonResponse?.services?.first
        viewModel.selectedProvider = selectedProvider
        // When
        canSaveRequest = viewModel.canSaveRequest(values: getMockValidInputsData(provider: selectedProvider))
        // Then
        XCTAssertTrue(canSaveRequest)
    }
    
    //MARK: - SaveRequest_onProviderRquiredFieldValid_onSuccessClosureIsCalled
    func test_saveRequest_onProviderRquiredFieldValid_onSuccessClosureIsCalled() {
        // Given
        var isRequestSaved = false
        var selectedProvider: Provider? {
            return viewModel.selectedService?.providers?.first
        }
        viewModel.jsonResponse = getMockJsonData()
        viewModel.selectedService = viewModel.jsonResponse?.services?.first
        viewModel.selectedProvider = selectedProvider
        // When
        viewModel.saveRequest(values: getMockValidInputsData(provider: selectedProvider), onComplete: { isSaved in
            isRequestSaved = isSaved
        })
        // Then
        XCTAssertTrue(isRequestSaved)
    }
    
}

private extension SendMoneyViewModelTests {
    
    func getMockJsonData() -> SendMoneyModel? {
        return JSONResources.sendMoney.loadFile(type: SendMoneyModel.self)
    }
    
    func getMockValidInputsData(provider: Provider?) -> [String] {
        var values = [String]()
        for input in provider?.requiredFields ?? [] {
            let newValue = input.type == .number || input.type == .msisdn ? "1234789": "Test"
            values.append(newValue)
        }
        return values
    }
    
    func getMockNotValidInputsData(provider: Provider?) -> [String?] {
        let values = [String?](repeating: nil, count: provider?.requiredFields?.count ?? 0)
        return values
    }
}
