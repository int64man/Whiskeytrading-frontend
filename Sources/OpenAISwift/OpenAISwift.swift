import Foundation
#if canImport(FoundationNetworking) && canImport(FoundationXML)
import FoundationNetworking
import FoundationXML
#endif

public enum OpenAIError: Error {
    case genericError(error: Error)
    case decodingError(error: Error)
}

public class OpenAISwift {
    fileprivate(set) var token: String?
    
    public init(authToken: String) {
        self.token = authToken
    }
}

