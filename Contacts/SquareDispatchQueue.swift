//
// Created by Michael Pace on 9/13/22.
//

import Foundation

protocol SquareDispatchQueue {
    func async(execute: @escaping @convention(block) () -> Void)
}

class ContactsDispatchQueue: SquareDispatchQueue {
    func async(execute: @escaping @convention(block) () -> Void) {
        DispatchQueue.main.async(execute: execute)
    }
}
