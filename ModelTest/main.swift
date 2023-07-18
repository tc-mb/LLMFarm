//
//  main.swift
//  ModelTest
//
//  Created by guinmoon on 20.05.2023.
//

import Foundation

let maxOutputLength = 512
var total_output = 0

let  INSTRUCTION_KEY = "### Instruction:";
let  RESPONSE_KEY    = "### Response:";
let  END_KEY         = "### End";
let  INTRO_BLURB     = "Below is an instruction that describes a task. Write a response that appropriately completes the request.";

func mainCallback(_ str: String, _ time: Double) -> Bool {
//    DispatchQueue.main.async {
//        print(str)
//    }
//    if (time>10){
//        return true
//    }
    total_output += str.count
    if(total_output>maxOutputLength){
        return true
    }
    
    return false
}

// dollyv2 prompt format
func prompt_for_generation(_ instruction:String) -> String{
    return INTRO_BLURB + "\n\n" + INSTRUCTION_KEY + "\n" + instruction + "\n\n" + RESPONSE_KEY + "\n";
}

func main(){
    print("Hello.")
    var input_text = "State the meaning of life. And tell about Stavropol."
    
//    let ai = AI(_modelPath: "/Users/guinmoon/Library/Containers/com.guinmoon.LLMFarm/Data/Documents/models/dolly-v2-3b-q5_1.bin",_chatName: "chat")
//    try? ai.loadModel(ModelInference.GPTNeoxInference)
//    ai.model.custom_prompt_format = "Below is an instruction that describes a task. Write a response that appropriately completes the request.### Instruction:{{prompt}}### Response:"
//    ai.model.promptFormat = .Custom
//    ai.model.promptFormat = .Dolly_b3
//    let ai = AI(_modelPath: "/Users/guinmoon/Library/Containers/com.guinmoon.LLMFarm/Data/Documents/models/AI-Dungeon-2-Classic.bin",_chatName: "chat")
//    try? ai.loadModel(ModelInference.GPT2)
//    ai.model.promptFormat = .None
//
//    let ai = AI(_modelPath: "/Users/guinmoon/dev/alpaca_llama_etc/replit-code-v1-3b-ggml-q5_1.bin",_chatName: "chat")
//    try? ai.loadModel(ModelInference.Replit)
//    ai.model.promptFormat = .None
    
    let ai = AI(_modelPath: "/Users/guinmoon/dev/alpaca_llama_etc/orca-mini-7b.ggmlv3.q2_K.bin",_chatName: "chat")
//    let ai = AI(_modelPath: "/Users/guinmoon/dev/alpaca_llama_etc/orca-mini-7b.ggmlv3.q3_K_M.bin",_chatName: "chat")
    var params:ModelContextParams = .default
    params.use_metal = true
    try? ai.loadModel(ModelInference.LLamaInference,contextParams: params)
    ai.model.promptFormat = .LLaMa
    
//    let ai = AI(_modelPath: "/Users/guinmoon/dev/alpaca_llama_etc/santacoder-q8_0.bin",_chatName: "chat")
//    try? ai.loadModel(ModelInference.Starcoder)
//    ai.model.promptFormat = .None
//    input_text = "def quicksort"
    
    ai.model.contextParams.seed = 0;
//    ai.model.promptStyle = .StableLM_Tuned
    
    
//    let input_text = "Tell about Stavropol."
//    let prompt = prompt_for_generation(input_text)
    let prompt = input_text
    let output = try?ai.model.predict(prompt, mainCallback)
    print(output!)
}

main()
