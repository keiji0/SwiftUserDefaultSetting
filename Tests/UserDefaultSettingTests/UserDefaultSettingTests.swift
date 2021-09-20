import XCTest
import Combine
@testable import UserDefaultSetting

final class UserDefaultSettingTests: XCTestCase {
    override func setUp() {
        super.setUp()
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
    }
    
    override class func tearDown() {
    }

    func test_DefaultValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: Int
        }

        let config = Config()
        XCTAssertEqual(config.value, Int())
    }
    
    func test_OverrideDefaultValue() {
        class Config {
            @UserDefaultValue(key: "value", defaultValue: 5)
            var value: Int
        }

        let config = Config()
        XCTAssertEqual(config.value, 5)
    }

    func test_StringValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: String
        }

        let config = Config()
        config.value = "hoge"
        XCTAssertEqual(config.value, "hoge")
    }

    func test_IntValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: Int
        }

        let config = Config()
        config.value = 8
        XCTAssertEqual(config.value, 8)
    }

    func test_BoolValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: Bool
        }

        let config = Config()
        config.value = true
        XCTAssertEqual(config.value, true)
    }

    func test_FloatValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: Float
        }

        let config = Config()
        config.value = 0.3
        XCTAssertEqual(config.value, 0.3)
    }

    func test_DoubleValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: Double
        }

        let config = Config()
        config.value = 0.3
        XCTAssertEqual(config.value, 0.3)
    }

    func test_DataValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: Data
        }

        let config = Config()
        let dt = "abc".data(using: .utf8)!
        config.value = dt
        XCTAssertEqual(config.value, dt)
    }

    func test_ArrayValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: [String]
        }

        let config = Config()
        config.value = ["123"]
        XCTAssertEqual(config.value, ["123"])
    }
    
    func test_NestedArrayValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: [[Int]]
        }

        let config = Config()
        config.value = [[1, 2], [3]]
        XCTAssertEqual(config.value, [[1, 2], [3]])
    }

    func test_DictionaryValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: [String: Int]
        }

        let config = Config()
        config.value = [
            "abc": 8
        ]
        XCTAssertEqual(config.value, [
            "abc": 8
        ])
    }

    func test_OptinalValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: Int?
        }

        let config = Config()
        config.value = nil
        XCTAssertEqual(config.value, nil)
    }

    func test_SetOptinalValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: Int?
        }

        let config = Config()
        config.value = 8
        XCTAssertEqual(config.value, 8)
    }

    func test_SetUUIDValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: UUID
        }

        let config = Config()
        let value = UUID()
        config.value = value
        XCTAssertEqual(config.value, value)
    }
    
    func test_SetUUIDOptinalValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: UUID?
        }

        let config = Config()
        let value = UUID()
        config.value = value
        XCTAssertEqual(config.value, value)
    }

    func test_SetInvalidUUIDValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: UUID
        }

        let config = Config()
        config.value = UUID()
        UserDefaults.standard.set(888, forKey: "value")
        XCTAssertEqual(config.value, UUID.defaultValue)
    }

    func test_SetArrayUUIDValue() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: [UUID]
        }

        let config = Config()
        let uuid1 = UUID()
        let uuid2 = UUID()
        let uuid3 = UUID()
        config.value = [ uuid1, uuid2, uuid3 ]
        XCTAssertEqual(config.value, [ uuid1, uuid2, uuid3 ])
    }

    func test_Event() {
        class Config {
            @UserDefaultValue(key: "value")
            var value: Int
        }

        let config = Config()
        var updatedValue = 0
        let canceler = config.$value.sink{ updatedValue = $0 }
        config.value = 20
        XCTAssertEqual(updatedValue, 20)
        canceler.cancel()
    }
}
