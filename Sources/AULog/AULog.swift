// The Swift Programming Language
// https://docs.swift.org/swift-book
//
//  File.swift
//
//
//  Created by lixindong on 2024/8/9.
//

import Foundation
import OSLog

public class AULog {
    static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "AULog", category: "main")
    
    #if DEBUG
    public static var printLog = true
    #else
    public static var printLog = false
    #endif
    
    @inline(__always)
    static func log(_ messages: Any..., file: String = #file, function: String = #function) {
        let message = messages.reduce("") { "\($0) \($1)" }
        if Self.printLog {
            let fileName = URL(fileURLWithPath: file).lastPathComponent.split(separator: ".")[0]
            logger.log("\(fileName).\(function): \(message)")
        }
    }
}

@inline(__always)
public func aulog(_ messages: Any..., file: String = #file, function: String = #function) {
    AULog.log(messages, file: file, function: function)
}

// inline log，格式如：时间(精确到ms): 调用位置的类名.方法名.参数 - message
@inline(__always)
public func log(_ message: String = "", level: LogLevel = .verbose, file: String = #file, function: String = #function) {
    aulog(level.rawValue, message, file: file, function: function)
}

@inline(__always)
public func log(_ level: LogLevel = .verbose, _ message: Any..., file: String = #file, function: String = #function) {
    aulog(level.rawValue, message, file: file, function: function)
}

public enum LogLevel: String {
    case verbose = ""
    case info = "🟣 "
    case node = "🟢 "
    case warning = "🟡 "
    case error = "🔴 "
}
