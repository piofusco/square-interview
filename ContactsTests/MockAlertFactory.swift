//
// Created by Michael Pace on 9/14/22.
//

import UIKit
@testable import Contacts

class MockAlertFactory: AlertFactory {
    var buildCount = 0

    override func build(message: String) -> UIAlertController {
        buildCount += 1

        return UIAlertController()
    }
}