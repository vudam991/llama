//
//  LlamaWrapper.h
//  llama
//
//  Created by Vu Dam on 10/11/26.
//

#import <Foundation/Foundation.h>

@interface LlamaWrapper : NSObject

- (BOOL)loadModelWithPath:(NSString *)modelPath;
- (NSString *)generateCompletion:(NSString *)prompt withMaxTokens:(int)maxTokens;

@end
