import Foundation
import XCTest
import RxSwift

@testable import XcodePM

struct TestModel: Codable, Equatable {
    let name: String
    static func ==(lhs: TestModel, rhs: TestModel) -> Bool {
        return lhs.name == rhs.name
    }
}

final class KeyValueStorageTests: XCTestCase {
    
    var subject: KeyValueStorage!
    
    override func setUp() {
        super.setUp()
        subject = KeyValueStorage(name: "test")
    }
    
    override func tearDown() {
        super.tearDown()
        subject.removeAll()
    }
    
    func test_write_writesTheCorrectValue() throws {
        let model = TestModel(name: "waka")
        try subject.write(model, key: "shakira")
        let got: TestModel? = subject.read(key: "shakira")
        XCTAssertEqual(got, model)
    }
    
    func test_write_writesNonCodableValues() throws {
        try subject.write("waka", key: "shakira")
        let got: String? = subject.read(key: "shakira")
        XCTAssertEqual(got, "waka")
    }
    
    func test_remove_removesTheValue() throws {
        let model = TestModel(name: "waka")
        try subject.write(model, key: "shakira")
        subject.remove(key: "shakira")
        let got: TestModel? = subject.read(key: "shakira")
        XCTAssertNil(got)
    }
    
    func test_removeAll_removesAllValues() throws {
        let model = TestModel(name: "waka")
        try subject.write(model, key: "shakira")
        try subject.write(model, key: "shakira2")
        subject.removeAll()
        let got1: TestModel? = subject.read(key: "shakira")
        let got2: TestModel? = subject.read(key: "shakira2")
        XCTAssertNil(got1)
        XCTAssertNil(got2)
    }
    
    func test_observe_notifiesWhenAValueChanges() throws {
        var got: String?
        _ = subject.observe(key: "shakira").subscribe(onNext: { (change: String?) in
            got = change
        })
        try subject.write("waka", key: "shakira")
        XCTAssertEqual(got, "waka")
    }
    
    func test_observe_notifiesWhenAValueIsRemoved() throws {
        var got: String? = "value"
        _ = subject.observe(key: "shakira").subscribe(onNext: { (change: String?) in
            got = change
        })
        subject.remove(key: "shakira")
        XCTAssertNil(got)
    }
}
