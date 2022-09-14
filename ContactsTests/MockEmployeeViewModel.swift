//
// Created by Michael Pace on 9/14/22.
//

@testable import Contacts

class MockEmployeeViewModel: EmployeeViewModel {
    var employees: [Employee] {
        get {
            guard !nextEmployees.isEmpty else { return [] }

            return nextEmployees
        }
    }
    var nextEmployees = [Employee]()

    var fetchEmployeesCount = 0

    func fetchEmployees() {
        fetchEmployeesCount += 1
    }
}