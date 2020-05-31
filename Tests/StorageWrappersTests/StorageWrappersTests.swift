import XCTest
@testable import StorageWrappers

struct User: Codable, Equatable {
    let name: String
    let email: String
}

final class StorageWrappersTests: XCTestCase {
 
    // MARK: Defaults
    
    @StoredData(key: "testDataKey", storage: DefaultsStorage.sharedInstance)
    var testDataInDefaults: Data?
    
    func testDefaultsStoredData() {
        let initialValue = testDataInDefaults
        XCTAssertNil(initialValue)
        
        let data = "test".data(using: .utf8)
        testDataInDefaults = data
        XCTAssertEqual(testDataInDefaults, data)
        
        testDataInDefaults = nil
        XCTAssertNil(testDataInDefaults)
    }
    
    @StoredString(key: "testStringKey", storage: DefaultsStorage.sharedInstance)
    var testStringInDefaults: String?
    
    func testDefaultsStoredString() {
        let initialValue = testStringInDefaults
        XCTAssertNil(initialValue)
        
        let string = "test"
        testStringInDefaults = string
        XCTAssertEqual(testStringInDefaults, string)
        
        testStringInDefaults = nil
        XCTAssertNil(testStringInDefaults)
    }
    
    @StoredCodable(key: "userKey", storage: DefaultsStorage.sharedInstance)
    var testUserInDefaults: User?
    
    func testDefaultsStoredCodable() {
        let initialValue = testUserInDefaults
        XCTAssertNil(initialValue)
        
        let user = User(name: "test", email: "test@email.com")
        testUserInDefaults = user
        XCTAssertEqual(testUserInDefaults, user)
        
        testUserInDefaults = nil
        XCTAssertNil(testUserInDefaults)
    }
    
    // MARK: Keychain
    
    @StoredData(key: "testDataKey", storage: KeychainStorage.sharedInstance)
    var testDataInKeychain: Data?

    func testKeychainStoredData() {
        let initialValue = testDataInKeychain
        XCTAssertNil(initialValue)
        
        let data = "test".data(using: .utf8)
        testDataInKeychain = data
        XCTAssertEqual(testDataInKeychain, data)
        
        testDataInKeychain = nil
        XCTAssertNil(testDataInKeychain)
    }

    @StoredString(key: "testStringKey", storage: KeychainStorage.sharedInstance)
    var testStringInKeychain: String?

    func testKeychainStoredString() {
        let initialValue = testStringInKeychain
        XCTAssertNil(initialValue)
        
        let string = "test"
        testStringInKeychain = string
        XCTAssertEqual(testStringInKeychain, string)
        
        testStringInKeychain = nil
        XCTAssertNil(testStringInKeychain)
    }

    @StoredCodable(key: "userKey", storage: KeychainStorage.sharedInstance)
    var testUserInKeychain: User?

    func testKeychainStoredCodable() {
        let initialValue = testUserInKeychain
        XCTAssertNil(initialValue)
        
        let user = User(name: "test", email: "test@email.com")
        testUserInKeychain = user
        XCTAssertEqual(testUserInKeychain, user)
        
        testUserInKeychain = nil
        XCTAssertNil(testUserInKeychain)
    }
}
