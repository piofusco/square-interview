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
        tableView.delegate = self
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

    private let employeeViewModel: EmployeeViewModel
    private let dispatchQueue: SquareDispatchQueue
    private let alertFactory: AlertFactory

    init(employeeViewModel: EmployeeViewModel, dispatchQueue: SquareDispatchQueue, alertFactory: AlertFactory) {
        self.employeeViewModel = employeeViewModel
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

        employeeViewModel.fetchEmployees()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension EmployeeListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !employeeViewModel.employees.isEmpty else { return 1 }

        return employeeViewModel.employees.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !employeeViewModel.employees.isEmpty else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "EmptyCell")
            cell.textLabel?.text = "There are no employees!"
            cell.detailTextLabel?.text = "Pull to refresh or tap the button in the right hand corner."
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell") as? EmployeeTableViewCell else {
            return UITableViewCell()
        }

        cell.setupViews(employee: employeeViewModel.employees[indexPath.row])

        return cell
    }
}

extension EmployeeListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController(employee: employeeViewModel.employees[indexPath.row])
        navigationController?.pushViewController(detailViewController, animated: false)
    }
}

extension EmployeeListViewController: EmployeeViewModelDelegate {
    func employeesDidUpdate() {
        dispatchQueue.async { [weak self] in
            guard let self = self else { return }

            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.spinner.stopAnimating()
        }
    }

    func employeesDidFail(error: Error) {
        dispatchQueue.async { [weak self] in
            guard let self = self else { return }

            let alert = self.alertFactory.build(message: error.localizedDescription)
            self.navigationController?.present(alert, animated: true)
            self.refreshControl.endRefreshing()
            self.spinner.stopAnimating()
        }
    }
}
