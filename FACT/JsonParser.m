//
//  JsonParser.m
//  PhotoBrowser
//
//  Created by Sowmya Srinivasan on 09/05/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import "JsonParser.h"
#import "Model.h"

@implementation JsonParser
-(NSMutableArray *)parseData:(NSDictionary *)details
{
    NSMutableArray * data = [[NSMutableArray alloc] init];
    for(NSDictionary * item in details)
    {
        Model * model = [[Model alloc] init];
        if([item valueForKey:@"title"]!= [NSNull null])
        {
            model.title = [item valueForKey:@"title"];
        }
        else
        {
            model.title = @"";
            
        }
        if([item valueForKey:@"description"] != [NSNull null])
        {
            model.details = [item valueForKey:@"description"];
        }
        else
        {
            model.details = @"";
        }
        if([item valueForKey:@"imageHref"]!= [NSNull null])
        {
            model.imageURL = [item valueForKey:@"imageHref"];
        }
        else
        {
            model.imageURL = @"";
        }
        [data addObject:model];
    }
    return data;
}
@end
