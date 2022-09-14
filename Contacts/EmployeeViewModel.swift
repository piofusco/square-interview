//
// Created by Michael Pace on 9/14/22.
//

import Foundation

protocol EmployeeViewModelDelegate: AnyObject {
    func employeesDidUpdate()
    func employeesDidFail(error: Error)
}

protocol EmployeeViewModel: AnyObject {
    var employees: [Employee] { get }

    func fetchEmployees()
}

class ContactViewModel: EmployeeViewModel {
    private(set) var employees: [Employee]

    weak var delegate: EmployeeViewModelDelegate?

    private let employeeAPI: EmployeeAPI

    init(employeeAPI: EmployeeAPI) {
        self.employeeAPI = employeeAPI

        employees = []
    }

    func fetchEmployees() {
        employeeAPI.fetchEmployees { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success(let employees):
                    self.employees = employees
                    self.delegate?.employeesDidUpdate()
                case .failure(let error):
                    self.delegate?.employeesDidFail(error: error)
            }
        }
    }
}