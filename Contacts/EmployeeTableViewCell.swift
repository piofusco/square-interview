//
//  ViewController.swift
//  Contacts
//
//  Created by Michael Pace on 9/13/22.
//

import UIKit

import Kingfisher

class EmployeeTableViewCell: UITableViewCell {
    private lazy var iconImage: UIImageView = {
        let iconImage = UIImageView()
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.kf.indicatorType = .activity
        return iconImage
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var contactInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var employeeLabel: UILabel = {
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

        contentView.addSubview(iconImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(contactInfoLabel)
        contentView.addSubview(employeeLabel)
        contentView.addSubview(biographyLabel)

        NSLayoutConstraint.activate([
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            iconImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            iconImage.heightAnchor.constraint(equalToConstant: 60),
            iconImage.widthAnchor.constraint(equalToConstant: 60),

            nameLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            contactInfoLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 12),
            contactInfoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            contactInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            employeeLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 12),
            employeeLabel.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 5),
            employeeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            biographyLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 12),
            biographyLabel.topAnchor.constraint(equalTo: employeeLabel.bottomAnchor, constant: 5),
            biographyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            biographyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = ""
        contactInfoLabel.text = ""
        employeeLabel.text = ""
        biographyLabel.text = ""
    }

    func setupViews(employee: Employee) {
        nameLabel.text = employee.fullName
        contactInfoLabel.text = employee.emailAddress + " | " + (employee.phoneNumber ?? "")
        employeeLabel.text = employee.team + " | " + employee.employeeType.description
        biographyLabel.text = employee.biography ?? ""

        if let largeURLString = employee.photoUrlLarge,
           let url = URL(string: largeURLString) {
            iconImage.kf.setImage(with: url)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}