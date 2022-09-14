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
    private var mockAlertFactory: MockAlertFactory!

    private let stubTableView = UITableView()

    override func setUp() {
        super.setUp()

        mockEmployeeAPI = MockEmployeeAPI()
        mockDispatchQueue = MockDispatchQueue()
        mockAlertFactory = MockAlertFactory()

        subject = EmployeeListViewController(
            employeeAPI: mockEmployeeAPI,
            dispatchQueue: mockDispatchQueue,
            alertFactory: mockAlertFactory
        )
    }

    func test_defaultsToZeroEmployees() {
        subject.viewDidLoad()

        XCTAssertEqual(subject.tableView(stubTableView, numberOfRowsInSection: 0), 1)
    }

    func test_viewDidLoad_loadEmployees_success_reloadTableViewWithNewEmployees() {
        mockEmployeeAPI.nextFetchEmployeesResponses = [
            .success([
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
            ])
        ]

        subject.viewDidLoad()

        XCTAssertEqual(mockEmployeeAPI.fetchEmployeesCount, 1)
        XCTAssertEqual(mockDispatchQueue.asyncCount, 1)
        XCTAssertEqual(mockAlertFactory.buildCount, 0)
        XCTAssertEqual(subject.tableView(stubTableView, numberOfRowsInSection: 0), 2)
    }

    func test_viewDidLoad_loadEmployees_failure_createAlert() {
        mockEmployeeAPI.nextFetchEmployeesResponses = [.failure(NSError(domain: "does not matter", code: -1))]

        subject.viewDidLoad()

        XCTAssertEqual(mockEmployeeAPI.fetchEmployeesCount, 1)
        XCTAssertEqual(mockDispatchQueue.asyncCount, 1)
        XCTAssertEqual(mockAlertFactory.buildCount, 1)
        XCTAssertEqual(subject.tableView(stubTableView, numberOfRowsInSection: 0), 1)
    }
}
