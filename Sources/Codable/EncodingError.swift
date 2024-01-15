public struct EncodingError {
    public let error: Swift.Error

    public init(_ error: Swift.Error) {
        self.error = error
    }
}

public struct KeyedEncodingError<Key: CodingKey> {
    public let error: Swift.Error

    public init(_ error: Swift.Error) {
        self.error = error
    }
}

extension EncodingError: Swift.Encoder {
    public var codingPath: [CodingKey] { return [] }
    public var userInfo: [CodingUserInfoKey: Any] { return [:] }

    public func container<Key>(
        keyedBy type: Key.Type
    ) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        return KeyedEncodingContainer(KeyedEncodingError(error))
    }

    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        return self
    }

    public func singleValueContainer() -> SingleValueEncodingContainer {
        return self
    }
}

extension EncodingError: SingleValueEncodingContainer {
    public func encodeNil() throws {
        throw error
    }

    public func encode<T>(_ value: T) throws where T: Encodable {
        throw error
    }
}

extension EncodingError: UnkeyedEncodingContainer {
    public var count: Int { return 0 }

    public func nestedContainer<NestedKey>(
        keyedBy keyType: NestedKey.Type
    ) -> KeyedEncodingContainer<NestedKey> {
        return KeyedEncodingContainer(KeyedEncodingError(error))
    }

    public func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        return self
    }

    public func superEncoder() -> Swift.Encoder {
        return self
    }
}

extension KeyedEncodingError: KeyedEncodingContainerProtocol {
    public var codingPath: [CodingKey] { return [] }
    public var userInfo: [CodingUserInfoKey: Any] { return [:] }

    public func encodeNil(forKey key: Key) throws {
        throw error
    }

    public func encode<T: Encodable>(_ value: T, forKey key: Key) throws {
        throw error
    }

    public func nestedContainer<NestedKey>(
        keyedBy keyType: NestedKey.Type,
        forKey key: Key
    ) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        return KeyedEncodingContainer(KeyedEncodingError<NestedKey>(error))
    }

    public func nestedUnkeyedContainer(
        forKey key: Key
    ) -> UnkeyedEncodingContainer {
        return EncodingError(error)
    }

    public func superEncoder() -> Swift.Encoder {
        return EncodingError(error)
    }

    public func superEncoder(forKey key: Key) -> Swift.Encoder {
        return EncodingError(error)
    }
}
