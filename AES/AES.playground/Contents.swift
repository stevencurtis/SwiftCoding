import Foundation
import CommonCrypto

enum AESError: Error {
    case keySizeError
    case keyDataError
}

public struct AES256 {
    private let key: Data

    public init?(key: String) throws {
        guard key.count == kCCKeySizeAES256 else {
            throw AESError.keySizeError
        }
        guard let keyData = key.data(using: .utf8) else {
            throw AESError.keyDataError
        }
        self.key = keyData
    }

    public func encrypt(messageData: Data?) -> Data? {
        guard let messageData else { return nil}
        return crypt(data: messageData, option: CCOperation(kCCEncrypt))
    }

    public func decrypt(encryptedData: Data?) -> Data? {
        return crypt(data: encryptedData, option: CCOperation(kCCDecrypt))
    }

    private func crypt(data: Data?, option: CCOperation) -> Data? {
        guard let data = data else { return nil }
        var outputBuffer = [UInt8](repeating: 0, count: data.count + kCCBlockSizeAES128)
        var numBytesEncrypted = 0
        let status = CCCrypt(
            option,
            CCAlgorithm(kCCAlgorithmAES),
            CCOptions(kCCOptionPKCS7Padding),
            Array(key),
            kCCKeySizeAES256,
            nil,
            Array(data),
            data.count,
            &outputBuffer, outputBuffer.count, &numBytesEncrypted
        )
        guard status == kCCSuccess else { return nil }
        let outputBytes = outputBuffer.prefix(numBytesEncrypted)
        return Data(outputBytes)
    }
}

let message = "testing that it encrypts and decrypts"
let data = message.data(using: .utf8)
let key = "Uc1gU2FsdGVkX19LW0ZSbvKUJT6TnTfI"

let encryptedData = try? AES256(key: key)?.encrypt(messageData: data)
if let decryptedData = try? AES256(key: key)?.decrypt(encryptedData: encryptedData) {
    let decryptedMessage = String(data: decryptedData, encoding: .utf8)
    if decryptedMessage == message {
        print("Encryption and decryption successful")
    } else {
        print("Encryption and decryption failed")
    }
}
