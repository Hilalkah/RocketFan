//
//  RocketFanTests.swift
//  RocketFanTests
//
//  Created by Hilal on 13.01.2022.
//

import XCTest
@testable import RocketFan

class RocketFanTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTabCount() throws {
        let vc = HomeViewController()
        let count = vc.viewControllers?.count ?? 0
        XCTAssertEqual(count, 2)
    }

}
