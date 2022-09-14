//
//  EmployeeAPITests.swift
//  ContactsTests
//
//  Created by Michael Pace on 9/13/22.
//

import XCTest

@testable import Contacts

class EmployeeAPITest: XCTestCase {
    func test_fetchEmployees_callResume_ensureURL() {
        let mockURLSession = MockURLSession()
        let mockURLSessionDataTask = MockURLSessionDataTask()
        mockURLSession.nextDataTask = mockURLSessionDataTask
        let subject = ContactAPI(urlSession: mockURLSession)

        subject.fetchEmployees { _ in }

        XCTAssertTrue(mockURLSessionDataTask.didResume)
        guard let lastURL = mockURLSession.lastURL else {
            XCTFail("No URL was called")
            return
        }
        guard let urlComponents = URLComponents(string: lastURL.absoluteString) else {
            XCTFail("URL called was invalid")
            return
        }
        XCTAssertEqual(urlComponents.host, "s3.amazonaws.com")
        XCTAssertEqual(urlComponents.path, "/sq-mobile-interview/employees.json")
    }

    func test_fetchEmployees_200_callCompletionWithData() {
        let mockURLSession = MockURLSession()
        mockURLSession.nextResponses = [HTTPURLResponse.Happy200Request]
        mockURLSession.nextData = happyEmployeeResponseJSON
        mockURLSession.nextDataTask = MockURLSessionDataTask()
        let subject = ContactAPI(urlSession: mockURLSession)
        var completionDidRun = false
        var response: [Employee]?

        subject.fetchEmployees { result in
            completionDidRun = true

            switch result {
                case .success(let pageResponse): response = pageResponse
                case .failure(_): XCTFail("result shouldn't be a failure")
            }
        }

        XCTAssertTrue(completionDidRun)
        guard let response = response else {
            XCTFail("couldn't unwrap photos")
            return
        }
        XCTAssertEqual(response.count, 1)
        XCTAssertEqual(response[0].uuid, "some-uuid")
        XCTAssertEqual(response[0].fullName, "Eric Rogers")
        XCTAssertEqual(response[0].emailAddress, "erogers.demo@squareup.com")
        XCTAssertEqual(response[0].team, "Seller")
        XCTAssertEqual(response[0].employeeType, EmployeeType.fullTime)

        XCTAssertEqual(response[0].phoneNumber, "5556669870")
        XCTAssertEqual(response[0].biography, "A short biography describing the employee.")
        XCTAssertEqual(response[0].photoUrlSmall, "https://some.url/path1.jpg")
        XCTAssertEqual(response[0].photoUrlLarge, "https://some.url/path2.jpg")

    }

    func test_fetchEmployees_400_callCompletionWithFailure() {
        let mockURLSession = MockURLSession()
        mockURLSession.nextResponses = [HTTPURLResponse.BadRequestError]
        mockURLSession.nextDataTask = MockURLSessionDataTask()
        let subject = ContactAPI(urlSession: mockURLSession)
        var completionDidRun = false

        subject.fetchEmployees { result in
            switch result {
                case .success(_): XCTFail("result shouldn't be a failure")
                case .failure(let error):
                    completionDidRun = true
                    XCTAssertTrue(error is EmployeeAPIError)
            }
        }

        XCTAssertTrue(completionDidRun)
    }

    func test_fetchEmployees_500_callCompletionWithFailure() {
        let mockURLSession = MockURLSession()
        mockURLSession.nextResponses = [HTTPURLResponse.InternalServerError]
        mockURLSession.nextDataTask = MockURLSessionDataTask()
        let subject = ContactAPI(urlSession: mockURLSession)
        var completionDidRun = false

        subject.fetchEmployees { result in
            switch result {
                case .success(_): XCTFail("result shouldn't be a failure")
                case .failure(let error):
                    completionDidRun = true
                    XCTAssertTrue(error is EmployeeAPIError)
            }
        }

        XCTAssertTrue(completionDidRun)
    }

    func test_fetchEmployees_error_callCompletionWithError() {
        let mockURLSession = MockURLSession()
        mockURLSession.nextError = NSError(domain: "doesn't matter", code: 666)
        mockURLSession.nextDataTask = MockURLSessionDataTask()
        let subject = ContactAPI(urlSession: mockURLSession)
        var completionDidRun = false

        subject.fetchEmployees { result in
            switch result {
                case .success(_): XCTFail("result shouldn't be a failure")
                case .failure(_): completionDidRun = true
            }
        }

        XCTAssertTrue(completionDidRun)
    }
}

extension HTTPURLResponse {
    static var Happy200Request = HTTPURLResponse(url: URL(string: "https://does.not.matter")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static var BadRequestError = HTTPURLResponse(url: URL(string: "https://does.not.matter")!, statusCode: 400, httpVersion: nil, headerFields: nil)!
    static var InternalServerError = HTTPURLResponse(url: URL(string: "https://does.not.matter")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
}

fileprivate let happyEmployeeResponseJSON =
    """
    {
      "employees": [
        {
          "uuid": "some-uuid",
          "full_name": "Eric Rogers",
          "phone_number": "5556669870",
          "email_address": "erogers.demo@squareup.com",
          "biography": "A short biography describing the employee.",
          "photo_url_small": "https://some.url/path1.jpg",
          "photo_url_large": "https://some.url/path2.jpg",
          "team": "Seller",
          "employee_type": "FULL_TIME"
        }
      ]
    }
    """.data(using: .utf8)
