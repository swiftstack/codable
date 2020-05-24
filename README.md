# Codable

Helps you to throw an error on container request step, which is not allowed by the current Encodable design.

## Package.swift

```swift
.package(url: "https://github.com/swift-stack/codable.git", .branch("dev"))
```

## Usage

```swift
struct Encoder: Swift.Encoder {
    func container<Key: CodingKey>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
        do {
            // try
        } catch {
            return KeyedEncodingContainer(KeyedEncodingError(error))
        }
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        do {
            // try
        } catch {
            return EncodingError(error)
        }
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        do {
            // try
        } catch {
            return EncodingError(error)
        }
    }
}
```
