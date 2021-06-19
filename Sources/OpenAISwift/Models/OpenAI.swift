//
//  Created by Adam Rush - OpenAISwift
//

import Foundation

public protocol Payload: Codable { }

public struct OpenAI<T: Payload>: Codable {
    public let object: String
    public let model: String?
    public let choices: [T]
}

public struct TextResult: 