//
//  EmployeeViewModelTests.swift
//  ContactsTests
//
//  Created by Michael Pace on 9/13/22.
//

import XCTest

@testable import Contacts

class EmployeeViewModelTest: XCTestCase {
    var subject: ContactViewModel!

    var mockEmployeeAPI: MockEmployeeAPI!
    var mockEmployeeViewModelDelegate: MockEmployeeViewModelDelegate!

    override func setUp() {
        super.setUp()

        mockEmployeeAPI = MockEmployeeAPI()
        mockEmployeeViewModelDelegate = MockEmployeeViewModelDelegate()
        subject = ContactViewModel(employeeAPI: mockEmployeeAPI)

        subject.delegate = mockEmployeeViewModelDelegate
    }

    func test_fetchEmployees_success_updateEmployees_callDelegate_callCompletion() {
        mockEmployeeAPI.nextFetchEmployeesResponses = [.success([
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
        ])]

        subject.fetchEmployees()

        XCTAssertEqual(mockEmployeeAPI.fetchEmployeesCount, 1)
        XCTAssertEqual(mockEmployeeViewModelDelegate.employeesDidUpdateCount, 1)
        XCTAssertEqual(mockEmployeeViewModelDelegate.employeesDidFailCount, 0)
        XCTAssertEqual(subject.employees.count, 2)
        XCTAssertEqual(subject.employees[0].uuid, "1")
        XCTAssertEqual(subject.employees[1].uuid, "2")
    }

    func test_fetchEmployees_failure_callDelegate() {
        mockEmployeeAPI.nextFetchEmployeesResponses = [.failure(NSError(domain: "does not matter", code: -1))]

        subject.fetchEmployees()

        XCTAssertEqual(mockEmployeeAPI.fetchEmployeesCount, 1)
        XCTAssertEqual(mockEmployeeViewModelDelegate.employeesDidUpdateCount, 0)
        XCTAssertEqual(mockEmployeeViewModelDelegate.employeesDidFailCount, 1)
        XCTAssertTrue(subject.employees.isEmpty)
    }
}
