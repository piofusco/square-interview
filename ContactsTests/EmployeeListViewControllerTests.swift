//
//  EmployeeListViewControllerTests.swift
//  ContactsTests
//
//  Created by Michael Pace on 9/13/22.
//

import UIKit
import XCTest

@testable import Contacts

class EmployeeListViewControllerTest: XCTestCase {
    private var subject: EmployeeListViewController!

    private var mockViewModel: MockEmployeeViewModel!
    private var mockDispatchQueue: MockDispatchQueue!
    private var mockAlertFactory: MockAlertFactory!

    private let stubTableView = UITableView()

    override func setUp() {
        super.setUp()

        mockViewModel = MockEmployeeViewModel()
        mockDispatchQueue = MockDispatchQueue()
        mockAlertFactory = MockAlertFactory()

        subject = EmployeeListViewController(
            employeeViewModel: mockViewModel,
            dispatchQueue: mockDispatchQueue,
            alertFactory: mockAlertFactory
        )
    }

    func test_defaultsToZeroEmployees() {
        subject.viewDidLoad()

        XCTAssertEqual(subject.tableView(stubTableView, numberOfRowsInSection: 0), 1)
    }

    func test_EmployeeViewModelDelegate_employeesDidUpdate_reloadTableViewWithEmployeesFromVM() {
        mockViewModel.nextEmployees = [
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

        subject.employeesDidUpdate()

        XCTAssertEqual(mockDispatchQueue.asyncCount, 1)
        XCTAssertEqual(mockAlertFactory.buildCount, 0)
        XCTAssertEqual(subject.tableView(stubTableView, numberOfRowsInSection: 0), 2)
    }

    func test_viewDidLoad_employeesDidFail_createAlert() {
        subject.employeesDidFail(error: NSError(domain: "does not matter", code: -1))

        XCTAssertEqual(mockDispatchQueue.asyncCount, 1)
        XCTAssertEqual(mockAlertFactory.buildCount, 1)
        XCTAssertEqual(subject.tableView(stubTableView, numberOfRowsInSection: 0), 1)
    }
}
