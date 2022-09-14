//
// Created by Michael Pace on 9/13/22.
//

import UIKit

class AlertFactory {
    func build(message: String) -> UIAlertController {
        let controller = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default))
        return controller
    }
}
