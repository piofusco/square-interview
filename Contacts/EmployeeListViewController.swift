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
        tableView.refreshControl = refreshControl
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: "EmployeeTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadEmployees), for: .valueChanged)
        return refreshControl
    }()

    private var employees: [Employee] = []

    private let employeeAPI: EmployeeAPI
    private let dispatchQueue: SquareDispatchQueue
    private let alertFactory: AlertFactory

    init(employeeAPI: EmployeeAPI, dispatchQueue: SquareDispatchQueue, alertFactory: AlertFactory) {
        self.employeeAPI = employeeAPI
        self.dispatchQueue = dispatchQueue
        self.alertFactory = alertFactory

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(loadEmployees)
        )
        navigationItem.title = "Contacts"

        view = tableView
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadEmployees()
    }

    @objc private func loadEmployees() {
        spinner.startAnimating()

        employeeAPI.fetchEmployees { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success(let employees):
                    self.dispatchQueue.async {
                        self.employees = employees
                        self.tableView.reloadData()
                        self.refreshControl.endRefreshing()
                        self.spinner.stopAnimating()
                    }
                case .failure(let error):
                    self.dispatchQueue.async {
                        let alert = self.alertFactory.build(message: error.localizedDescription)
                        self.navigationController?.present(alert, animated: true)
                        self.refreshControl.endRefreshing()
                        self.spinner.stopAnimating()
                    }
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension EmployeeListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !employees.isEmpty else {
            return 1
        }

        return employees.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !employees.isEmpty else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "EmptyCell")
            cell.textLabel?.text = "There are no employees!"
            cell.detailTextLabel?.text = "Pull to refresh or tap the button in the right hand corner."
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell") as? EmployeeTableViewCell else {
            return UITableViewCell()
        }

        cell.setupViews(employee: employees[indexPath.row])

        return cell
    }
}
