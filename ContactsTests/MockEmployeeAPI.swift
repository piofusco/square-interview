//
// Created by Michael Pace on 9/14/22.
//

@testable import Contacts

class MockEmployeeAPI: EmployeeAPI {
    var nextFetchEmployeesResponses: [Result<[Employee], Error>] = []
    var fetchEmployeesCount = 0

    func fetchEmployees(completion: @escaping (Result<[Employee], Error>) -> ()) {
        fetchEmployeesCount += 1

        if nextFetchEmployeesResponses.count > 0 {
            completion(nextFetchEmployeesResponses.removeFirst())
        }
    }
}