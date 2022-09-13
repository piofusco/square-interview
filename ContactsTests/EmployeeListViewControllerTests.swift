//
//  EmployeeAPITests.swift
//  ContactsTests
//
//  Created by Michael Pace on 9/13/22.
//

import UIKit
import XCTest

@testable import Contacts

class EmployeeListViewControllerTest: XCTestCase {
    private var subject: EmployeeListViewController!

    private var mockEmployeeAPI: MockEmployeeAPI!
    private var mockDispatchQueue: MockDispatchQueue!

    private let stubTableView = UITableView()

    override func setUp() {
        super.setUp()

        mockEmployeeAPI = MockEmployeeAPI()
        mockDispatchQueue = MockDispatchQueue()

        subject = EmployeeListViewController(
            employeeAPI: mockEmployeeAPI,
            dispatchQueue: mockDispatchQueue
        )
    }

    func test_defaultsToZeroEmployees() {
        subject.viewDidLoad()

        XCTAssertEqual(subject.tableView(stubTableView, numberOfRowsInSection: 0), 0)
    }

    func test_viewDidLoad_loadEmployees_reloadTableViewWithNewEmployees() {
        mockEmployeeAPI.nextFetchEmployeesResponse = [
            [
                Employee(
                    uuid: "1",
                    fullName: "",
                    emailAddress: "",
                    team: "",
                    employeeType: .fullTime,
                    phoneNumber: nil,
                    biography: nil,
                    photoUrlSmall: nil,
                    photoUrlLarge: nil
                ),
                Employee(
                    uuid: "2",
                    fullName: "",
                    emailAddress: "",
                    team: "",
                    employeeType: .fullTime,
                    phoneNumber: nil,
                    biography: nil,
                    photoUrlSmall: nil,
                    photoUrlLarge: nil
                )
            ]
        ]

        subject.viewDidLoad()

        XCTAssertEqual(mockEmployeeAPI.fetchEmployeesCount, 1)
        XCTAssertEqual(mockDispatchQueue.asyncCount, 1)
        XCTAssertEqual(subject.tableView(stubTableView, numberOfRowsInSection: 0), 2)
    }
}

class MockEmployeeAPI: EmployeeAPI {
    var nextFetchEmployeesResponse: [[Employee]] = []
    var fetchEmployeesCount = 0

    func fetchEmployees(completion: @escaping (Result<[Employee], Error>) -> ()) {
        fetchEmployeesCount += 1

        if nextFetchEmployeesResponse.count > 0 {
            completion(Result.success(nextFetchEmployeesResponse.removeFirst()))
        }
    }
}

class MockDispatchQueue: SquareDispatchQueue {
    var asyncCount = 0

    func async(execute: @escaping @convention(block) () -> ()) {
        asyncCount += 1

        execute()
    }
}


