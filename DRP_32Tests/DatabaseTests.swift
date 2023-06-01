//
//  DatabaseTests.swift
//  DRP_32Tests
//
//  Created by 蒋伯源 on 2023/6/1.
//

import XCTest
@testable import DRP_32

class FetchUsersTests: XCTestCase {
    var urlString: String!

    override func setUp() {
        super.setUp()
        // Provide your testing URL here
        urlString = "https://drp32-backend.herokuapp.com/todos"
    }

    override func tearDown() {
        urlString = nil
        super.tearDown()
    }
    
    func testCanAddTodo() {
        let expectation = self.expectation(description: "Posting")
        var returnedData: Todo?
        var returnedError: Error?
        let data = Todo(title: "TonnyTangdsb")

        postData(urlString: urlString, data: data) { (todo, error) in
            returnedData = todo
            returnedError = error
            expectation.fulfill()
        }

        waitForExpectations(timeout: 30, handler: nil)
        
        XCTAssertNil(returnedError)
        XCTAssertEqual((returnedData ?? Todo(title: "")).title, "TonnyTangdsb")
    }

    func testCanFetchTodos() {
//        let clearExpectation = self.expectation(description: "Clearing")
        let fetchExpectation = self.expectation(description: "Fetching")
        var fetchedDatas: [Todo]?
        var fetchedError: Error?

//        func clearTodos() {
//            let url = URL(string: "https://drp32-backend.herokuapp.com/todos/removeAll")!
//            let task = URLSession.shared.dataTask(with: url)
//            task.resume()
//        }
//
//        clearTodos()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
//            fetchDatas(urlString: self.urlString) { (users, error) in
//                fetchedDatas = users
//                fetchedError = error
//                fetchExpectation.fulfill()
//
//            }
//        }
        
        fetchDatas(urlString: self.urlString) { (users, error) in
            fetchedDatas = users
            fetchedError = error
            fetchExpectation.fulfill()
        
        }
        
        self.waitForExpectations(timeout: 60, handler: nil)

        XCTAssertNil(fetchedError)
        XCTAssertNotNil(fetchedDatas)
    }
}
