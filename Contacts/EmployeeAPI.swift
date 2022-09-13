//
// Created by Michael Pace on 9/13/22.
//

import Foundation

protocol EmployeeAPI {
    func fetchEmployees(completion: @escaping (Result<[Employee], Error>) -> Void)
}

class ContactAPI: EmployeeAPI {
    private static let BASE_URL = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"

    private let urlSession: SquareURLSession

    init(urlSession: SquareURLSession) {
        self.urlSession = urlSession
    }

    func fetchEmployees(completion: @escaping (Result<[Employee], Error>) -> ()) {
        guard let url = URL(string: ContactAPI.BASE_URL) else { return }

        urlSession.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let error = error {
                    completion(Result.failure(error))
                }

                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    guard let data = data else { return }

                    var response: EmployeesResponse?
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    do {
                        response = try JSONDecoder().decode(EmployeesResponse.self, from: data)
                    } catch {
                        print(error)
                    }

                    if let responseToReturn = response { completion(Result.success(responseToReturn.employees)) }
                } else if response.statusCode == 400 {
                    completion(Result.failure(EmployeeAPIError.badRequest))
                } else if response.statusCode == 500 {
                    completion(Result.failure(EmployeeAPIError.internalServerError))
                }
            }
            .resume()
    }
}