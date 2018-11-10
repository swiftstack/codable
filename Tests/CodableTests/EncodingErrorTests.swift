import Test
@testable import Codable

class EncodingErrorTests: TestCase {
    struct Encoder: Swift.Encoder {
        struct Error: Swift.Error {}

        var codingPath: [CodingKey] { return [] }
        var userInfo: [CodingUserInfoKey : Any] { return [:] }

        func container<Key>(
            keyedBy type: Key.Type) -> KeyedEncodingContainer<Key>
            where Key: CodingKey
        {
            return KeyedEncodingContainer(KeyedEncodingError(Error()))
        }

        func unkeyedContainer() -> UnkeyedEncodingContainer {
            return EncodingError(Error())
        }

        func singleValueContainer() -> SingleValueEncodingContainer {
            return EncodingError(Error())
        }
    }

    func testKeyedContainer() {
        struct User: Encodable {
            let name: String

            enum CodingKeys: CodingKey {
                case name
            }

            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: User.CodingKeys.self)
                try container.encode(name, forKey: .name)
            }
        }

        let encoder = Encoder()
        let user = User(name: "coder")
        assertThrowsError(try user.encode(to: encoder)) { error in
            assertNotNil(error as? Encoder.Error)
        }
    }

    func testUnkeyedContainer() {
        struct User: Encodable {
            let name: String

            enum CodingKeys: CodingKey {
                case name
            }

            func encode(to encoder: Encoder) throws {
                var container = encoder.unkeyedContainer()
                try container.encode(name)
            }
        }

        let encoder = Encoder()
        let user = User(name: "coder")
        assertThrowsError(try user.encode(to: encoder)) { error in
            assertNotNil(error as? Encoder.Error)
        }
    }

    func testSingleValueContainer() {
        struct User: Encodable {
            let name: String

            enum CodingKeys: CodingKey {
                case name
            }

            func encode(to encoder: Encoder) throws {
                var container = encoder.singleValueContainer()
                try container.encode(name)
            }
        }

        let encoder = Encoder()
        let user = User(name: "coder")
        assertThrowsError(try user.encode(to: encoder)) { error in
            assertNotNil(error as? Encoder.Error)
        }
    }
}
