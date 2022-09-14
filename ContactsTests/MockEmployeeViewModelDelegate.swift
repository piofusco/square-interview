//
// Created by Michael Pace on 9/14/22.
//

@testable import Contacts

class MockEmployeeViewModelDelegate: EmployeeViewModelDelegate {
    var employeesDidUpdateCount = 0

    func employeesDidUpdate() {
        employeesDidUpdateCount += 1
    }

    var employeesDidFailCount = 0

    func employeesDidFail(error: Error) {
        employeesDidFailCount += 1
    }
}