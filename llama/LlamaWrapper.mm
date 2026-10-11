//
//  LlamaWrapper.mm
//  llama
//
//  Created by Vu Dam on 10/11/26.
//

#import "LlamaWrapper.h"
#include "llama.h" // Imported from your XCFramework headers
#include <string>

@implementation LlamaWrapper {
    llama_model *model;
    llama_context *ctx;
}

- (BOOL)loadModelWithPath:(NSString *)modelPath {
    // 1. Initialize llama backend (required once)
    llama_backend_init();
    
    // 2. Setup model params
    auto mparams = llama_model_default_params();
    
    // 3. Load the model
    model = llama_model_load_from_file([modelPath UTF8String], mparams);
    if (!model) {
        NSLog(@"Failed to load GGUF model");
        return NO;
    }
    
    // 4. Setup context params (Enables Metal GPU acceleration if compiled with LLAMA_METAL)
    auto cparams = llama_context_default_params();
    cparams.n_ctx = 2048; // Context window size
    
    ctx = llama_init_from_model(model, cparams);
    if (!ctx) {
        NSLog(@"Failed to create llama context");
        return NO;
    }
    
    return YES;
}

- (NSString *)generateCompletion:(NSString *)prompt withMaxTokens:(int)maxTokens {
    if (!ctx) return @"Model not loaded";
    
    // Simple placeholder structure. Real tokenization loop requires:
    // llama_tokenize(), llama_decode(), and llama_sampler_sample()
    std::string response = "Processing prompt: " + std::string([prompt UTF8String]);
    
    return [NSString stringWithUTF8String:response.c_str()];
}

- (void)dealloc {
    if (ctx) llama_free(ctx);
    if (model) llama_model_free(model);
    llama_backend_free();
}

@end
