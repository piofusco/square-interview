//
// Created by Michael Pace on 9/13/22.
//

import Foundation

struct EmployeesResponse: Decodable {
    let employees: [Employee]
}

enum EmployeeType: String, Decodable, CustomStringConvertible {
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"

    var description: String {
        switch self {
            case .fullTime: return "Full-time"
            case .partTime: return "Part-time"
            case .contractor: return "Contractor"
        }
    }
}

struct Employee: Decodable {
    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case emailAddress = "email_address"
        case team
        case employeeType = "employee_type"

        case phoneNumber = "phone_number"
        case biography
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
    }

    let uuid: String
    let fullName: String
    let emailAddress: String
    let team: String
    let employeeType: EmployeeType

    let phoneNumber: String?
    let biography: String?
    let photoUrlSmall: String?
    let photoUrlLarge: String?
}