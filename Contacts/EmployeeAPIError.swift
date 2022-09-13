//
// Created by Michael Pace on 9/13/22.
//

import Foundation

enum EmployeeAPIError: Error {
    case badRequest
    case internalServerError
    case unexpected(code: Int)
}

extension EmployeeAPIError: CustomStringConvertible {
    public var description: String {
        switch self {
            case .badRequest: return "Bad Request."
            case .internalServerError: return "Internal Server Error."
            case .unexpected(_): return "An unexpected error occurred."
        }
    }
}

extension EmployeeAPIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .badRequest:
                return NSLocalizedString(
                    "Description of bad request",
                    comment: "Bad Request."
                )
            case .internalServerError:
                return NSLocalizedString(
                    "Description of internal server error",
                    comment: "Internal Server Error."
                )
            case .unexpected(_):
                return NSLocalizedString(
                    "Description of unexpected",
                    comment: "An unexpected error occurred."
                )
        }
    }
}
