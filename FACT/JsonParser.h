//
//  JsonParser.h
//  PhotoBrowser
//
//  Created by Sowmya Srinivasan on 09/05/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParser : NSObject
-(NSMutableArray *)parseData:(NSDictionary *)details;
@end
