//
//  NetworkManagerTests.swift
//  Unify-Mobile-AppTests
//
//  Created by Melvin Asare on 04/06/2022.
//

import XCTest
import Foundation

@testable import Unify_Mobile_App

class NetworkManagerTests: XCTestCase {

    private var networkManager = NSObject()

    override func setUpWithError() throws {
        networkManager = NetworkManager() as! NSObject
    }



    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    override func tearDownWithError() throws {
       // networkManager = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
