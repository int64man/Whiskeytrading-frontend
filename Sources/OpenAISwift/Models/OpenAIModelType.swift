
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
    public enum GPT3: String {
        
        /// Most capable GPT-3 model. Can do any task the other models can do, often with higher quality, longer output and better instruction-following. Also supports inserting completions within text.
        ///
        /// > Model Name: text-davinci-003
        case davinci = "text-davinci-003"
        
        /// Very capable, but faster and lower cost than GPT3 ``davinci``.
        ///
        /// > Model Name: text-curie-001
        case curie = "text-curie-001"
        
        /// Capable of straightforward tasks, very fast, and lower cost.
        ///
        /// > Model Name: text-babbage-001
        case babbage = "text-babbage-001"
        
        /// Capable of very simple tasks, usually the fastest model in the GPT-3 series, and lowest cost.
        ///
        /// > Model Name: text-ada-001