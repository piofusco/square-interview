//
// Created by Michael Pace on 9/14/22.
//

@testable import Contacts

class MockDispatchQueue: SquareDispatchQueue {
    var asyncCount = 0

    func async(execute: @escaping @convention(block) () -> ()) {
        asyncCount += 1

        execute()
    }
}

