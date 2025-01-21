//
//  RequestListViewModelTests.swift
//  sendMoneyTests
//
//  Created by Ahmed Ezz on 21/01/2025.
//

import XCTest
import CoreData
@testable import sendMoney

final class RequestListViewModelTests: XCTestCase {

    private var viewModel: RequestListViewModel!
    private var coreDataManager: MockCoreDataManager!
    
    override func setUpWithError() throws {
        coreDataManager = MockCoreDataManager()
        viewModel = RequestListViewModel(coreDataManger: coreDataManager)
    }
    
    //MARK: - FetchData_onResponseIsNotValid_onFailureClosureIsCalled
    func test_fetchData_onResponseIsNotValid_onFailureClosureIsCalled() {
        // Given
        let context = coreDataManager?.fetchContext() ?? .init(concurrencyType: .mainQueueConcurrencyType)
        var isDataRetrieved = false
        // When
        createMockRequest(context: context)
        coreDataManager.saveData(context: context, onComplete: { _ in })
        viewModel.retrieveRequests(onComplete: { requests in
            isDataRetrieved = requests.count > 0
        })
        // Then
        XCTAssertTrue(isDataRetrieved)
    }
}

private extension RequestListViewModelTests {
    func createMockRequest(context: NSManagedObjectContext) {
        let requestId = UUID()
        let entity = MoneyRequest(context: context)
        entity.id = requestId
        entity.details = Data()
    }
}
