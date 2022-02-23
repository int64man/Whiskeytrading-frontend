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

extension OpenAISwift {
    /// Send a Completion to the OpenAI API
    /// - Parameters:
    ///   - prompt: The Text Prompt
    ///   - model: The AI Model to Use. Set to `OpenAIModelType.gpt3(.davinci)` by default which is the most capable model
    ///   - maxTokens: The limit character for the returned response, defaults to 16 as per the API
    ///   - completionHandler: Returns an OpenAI Data Model
    public func sendCompletion(with prompt: String, model: OpenAIModelType = .gpt3(.davinci), maxTokens: Int = 16, temperature: Double = 1, completionHandler: @escaping (Result<OpenAI<TextResult>, OpenAIError>) -> Void) {
        let endpoint = Endpoint.completions
        let body = Command(prompt: prompt, model: model.modelName, maxTokens: maxTokens, temperature: temperature)
        let request = prepareRequest(endpoint, body: body)
        
        makeRequest(request: request) { result in
            switch result {
            case .success(let success):
                do {
                    let res = try JSONDecoder().decode(OpenAI<TextResult>.self, from: success)
                    completionHandler(.success(res))
                } catch {
                    completionHandler(.failure(.decodingError(error: error)))
                }
            case .failure(let failure):
                completionHandler(.failure(.genericError(error: failure)))
            }
        }
    }
    
    /// Send a Edit request to the OpenAI API
    /// - Parameters:
    ///   - instruction: The Instruction For Example: "Fix the spelling mistake"
    ///   - model: The Model to use, the only support model is `text-davinci-edit-001`
    ///   - input: The Input For Example "My nam is Adam"
    ///   - completionHandler: Returns an OpenAI Data Model
    public func sendEdits(with instruction: String, model: OpenAIModelType = .feature(.davinci), input: String = "", completionHandler: @escaping (Result<OpenAI<TextResult>, OpenAIError>) -> Void) {
        let endpoint = Endpoint.edits
        let body = Instruction(instruction: instruction, model: model.modelName, input: input)
        let request = prepareRequest(endpoint, body: body)
        
        makeRequest(request: request) { result in
            switch result {
            case .success(let success):
                do {
                    let res = try JSONDecoder().decode(OpenAI<TextResult>.self, from: success)
                    completionHandler(.success(res))
                } catch {
                    completionHandler(.failure(.decodingError(error: error)))
                }
            case .failure(let failure):
                completionHandler(.failure(.genericError(error: failure)))
            }
        }
    }
    
    /// Send a Chat request to the OpenAI API
    /// - Parameters:
    ///   - messages: Array of `ChatMessages`
    ///   - model: The Model to use, the only support model is `gpt-3.5-turbo`
    ///   - maxTokens: used in OpenAI's text-generating API to specify the maximum number of tokens (words) that should be generated in response to a prompt. This parameter is used to prevent the model from generating excessively long or rambling responses that may not be relevant to the prompt. The actual length of the response may be shorter than the `maxTokens` value if the model determines that it has reached a natural stopping point in the generation process.
    ///   - temperature: a value that determines the level of creativity and diversity in the output of the API. Temperature values closer to 0 will generate more predictable and conservative output, while higher temperature values will generate more original and surprising output. Essentially, 