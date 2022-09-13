//
//  ViewController.swift
//  Contacts
//
//  Created by Michael Pace on 9/13/22.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var emailAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var teamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var employeeTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(fullNameLabel)
        contentView.addSubview(emailAddressLabel)
        contentView.addSubview(teamLabel)
        contentView.addSubview(employeeTypeLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(biographyLabel)

        NSLayoutConstraint.activate([
            fullNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            fullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            fullNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            emailAddressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            emailAddressLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 5),
            emailAddressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            teamLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            teamLabel.topAnchor.constraint(equalTo: emailAddressLabel.bottomAnchor, constant: 5),
            teamLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            employeeTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            employeeTypeLabel.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: 5),
            employeeTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            phoneNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            phoneNumberLabel.topAnchor.constraint(equalTo: employeeTypeLabel.bottomAnchor, constant: 5),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            biographyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            biographyLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 5),
            biographyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            biographyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        fullNameLabel.text = ""
        emailAddressLabel.text = ""
        teamLabel.text = ""
        employeeTypeLabel.text = ""
        phoneNumberLabel.text = ""
        biographyLabel.text = ""
    }

    func setupViews(employee: Employee) {
        fullNameLabel.text = employee.fullName
        emailAddressLabel.text = employee.emailAddress
        teamLabel.text = employee.team
        employeeTypeLabel.text = employee.employeeType.rawValue
        phoneNumberLabel.text = employee.phoneNumber ?? ""
        biographyLabel.text = employee.biography ?? ""
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}