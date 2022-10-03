//
//  ViewController.swift
//  Contacts
//
//  Created by Michael Pace on 9/13/22.
//

import UIKit

import Kingfisher

class DetailViewController: UIViewController {
    private lazy var iconImage: UIImageView = {
        let iconImage = UIImageView()
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.kf.indicatorType = .activity
        if let largeURLString = employee.photoUrlLarge,
           let url = URL(string: largeURLString) {
            iconImage.kf.setImage(with: url)
        }
        return iconImage
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Name: \(employee.fullName)"
        return label
    }()

    private lazy var emailAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "\(employee.emailAddress)"
        label.textColor = .blue

        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectEmail))
        label.addGestureRecognizer(tapGesture)

        return label
    }()

    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        if let phoneNumber = employee.phoneNumber {
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectPhoneNumber))
            label.addGestureRecognizer(tapGesture)
            label.textColor = .blue
        }

        label.text = "\(employee.phoneNumber ?? "NA")"

        return label
    }()

    private lazy var teamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Team: \(employee.team)"
        return label
    }()

    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Type: \(employee.employeeType.description)"
        return label
    }()

    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Biography: \(employee.biography ?? "")"
        return label
    }()

    private let employee: Employee

    init(employee: Employee) {
        self.employee = employee

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        navigationItem.title = employee.fullName

        view.addSubview(iconImage)
        view.addSubview(nameLabel)
        view.addSubview(emailAddressLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(teamLabel)
        view.addSubview(typeLabel)
        view.addSubview(biographyLabel)

        NSLayoutConstraint.activate([
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            iconImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            iconImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            iconImage.heightAnchor.constraint(equalTo: iconImage.widthAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),

            emailAddressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            emailAddressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            emailAddressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),

            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            phoneNumberLabel.topAnchor.constraint(equalTo: emailAddressLabel.bottomAnchor, constant: 5),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),

            teamLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            teamLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 5),
            teamLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),

            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            typeLabel.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: 5),
            typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),

            biographyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            biographyLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 5),
            biographyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc private func didSelectEmail() {
        if let url = URL(string: "mailto:\(employee.emailAddress)") {
            UIApplication.shared.open(url)
        }
    }

    @objc private func didSelectPhoneNumber() {
        guard let phoneNumber = employee.phoneNumber else { return }

        if let url = URL(string: "tel:\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }
}
