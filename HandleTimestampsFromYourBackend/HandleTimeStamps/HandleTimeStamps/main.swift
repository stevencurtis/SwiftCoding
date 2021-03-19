//
//  main.swift
//  HandleTimeStamps
//
//  Created by Steven Curtis on 19/03/2021.
//

import Foundation

struct User: Codable {
    let user: String
    let timeStamp: Date
}

let jsonStringUnixEpoch = """
{
    "user": "Noah",
    "time_stamp": 1616112000
}
"""

let jsonStringiso = """
{
    "user": "Noah",
    "time_stamp": "2021-03-19T09:37:20+0000"
}
"""

let decoderUnix = JSONDecoder()
decoderUnix.keyDecodingStrategy = .convertFromSnakeCase
decoderUnix.dateDecodingStrategy = .secondsSince1970
if let data = jsonStringUnixEpoch.data(using: .utf8), let usersUnix = try? decoderUnix.decode(User.self, from: data) {
    print(usersUnix)
}

let decoderiso = JSONDecoder()
decoderiso.keyDecodingStrategy = .convertFromSnakeCase
decoderiso.dateDecodingStrategy = .iso8601
if let data = jsonStringiso.data(using: .utf8),let usersiso = try? decoderiso.decode(User.self, from: data) {
    print(usersiso)
}

let jsonStringisoMilliseconds = """
{
    "user": "Noah",
    "time_stamp": "2019-01-18T10:15:29.979Z"
}
"""

let decoderisoMilliseconds = JSONDecoder()
decoderisoMilliseconds.keyDecodingStrategy = .convertFromSnakeCase
decoderisoMilliseconds.dateDecodingStrategy = .iso8601
if let data = jsonStringisoMilliseconds.data(using: .utf8), let usersMilliseconds = try? decoderisoMilliseconds.decode(User.self, from: data) {
    print(usersMilliseconds) // never executes
}



extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}

extension Formatter {
    static let iso8601withSeconds = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    var iso8601withSeconds: String { return Formatter.iso8601withSeconds.string(from: self) }
}

extension String {
    var iso8601withSeconds: Date? { return Formatter.iso8601withSeconds.date(from: self) }
}

extension JSONDecoder.DateDecodingStrategy {
    static let iso8601withSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        guard let date = Formatter.iso8601withSeconds.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container,
                  debugDescription: "Invalid date in iso8601withSeconds: " + string)
        }
        return date
    }
}

let decoderisoMillisecondsAttempt = JSONDecoder()
decoderisoMillisecondsAttempt.keyDecodingStrategy = .convertFromSnakeCase
decoderisoMillisecondsAttempt.dateDecodingStrategy = .iso8601withSeconds
if let data = jsonStringisoMilliseconds.data(using: .utf8),let usersMillisecondsAttempt = try? decoderisoMillisecondsAttempt.decode(User.self, from: data) {
    print(usersMillisecondsAttempt)
}








extension Formatter {
    static let iso8601withFractionalSeconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}

extension JSONDecoder.DateDecodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        guard let date = Formatter.iso8601withFractionalSeconds.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container,
                  debugDescription: "Invalid date in iso8601withSeconds: " + string)
        }
        return date
    }
}

extension JSONEncoder.DateEncodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        var container = $1.singleValueContainer()
        try container.encode(Formatter.iso8601withFractionalSeconds.string(from: $0))
    }
}

let decoderisoMillisecondsCustom = JSONDecoder()
decoderisoMillisecondsCustom.keyDecodingStrategy = .convertFromSnakeCase
decoderisoMillisecondsCustom.dateDecodingStrategy = .iso8601withFractionalSeconds
let formatter = ISO8601DateFormatter()
formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
if let data = jsonStringisoMilliseconds.data(using: .utf8), let usersMillisecondsCustom = try? decoderisoMillisecondsCustom.decode(User.self, from: data) {
    print(usersMillisecondsCustom)
}
