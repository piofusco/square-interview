//
//  ViewController.swift
//  Contacts
//
//  Created by Michael Pace on 9/13/22.
//

import UIKit

class EmployeeListViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.estimatedRowHeight = 150
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: "EmployeeTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()

    private var employees: [Employee] = []

    private let employeeAPI: EmployeeAPI
    private let dispatchQueue: SquareDispatchQueue

    init(employeeAPI: EmployeeAPI, dispatchQueue: SquareDispatchQueue) {
        self.employeeAPI = employeeAPI
        self.dispatchQueue = dispatchQueue

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()

        navigationItem.title = "Contacts"

        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadEmployees()
    }

    private func loadEmployees() {
        employeeAPI.fetchEmployees { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success(let employees):
                    self.dispatchQueue.async {
                        self.employees = employees
                        self.tableView.reloadData()
                    }
                case .failure(let error): print(error)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension EmployeeListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employees.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !employees.isEmpty && indexPath.row < employees.count else {
            return UITableViewCell()
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell") as? EmployeeTableViewCell else {
            return UITableViewCell()
        }

        cell.setupViews(employee: employees[indexPath.row])

        return cell
    }
}
