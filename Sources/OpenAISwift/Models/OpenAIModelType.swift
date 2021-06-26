
//
//  OpenAIModelType.swift
//  
//
//  Created by Yash Shah on 06/12/2022.
//

import Foundation

/// The type of model used to generate the output
public enum OpenAIModelType {
    /// ``GPT3`` Family of Models
    case gpt3(GPT3)
    
    /// ``Codex`` Family of Models
    case codex(Codex)
    
    /// ``Feature``Family of Models
    case feature(Feature)
    
    /// ``Chat``Family of Models
    case chat(Chat)
    
    public var modelName: String {
        switch self {
        case .gpt3(let model): return model.rawValue
        case .codex(let model): return model.rawValue
        case .feature(let model): return model.rawValue
        case .chat(let model): return model.rawValue
        }
    }
    
    /// A set of models that can understand and generate natural language
    ///
    /// [GPT-3 Models OpenAI API Docs](https://beta.openai.com/docs/models/gpt-3)