//
//  NetworkLayer.m
//  PhotoBrowser
//
//  Created by Sowmya Srinivasan on 07/05/18.
//  Copyright © 2018 Wipro. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NetworkLayer.h"
#import "JsonParser.h"

@implementation NetworkLayer

-(void)downloadDatacompletionBlock:(void (^)(BOOL succeeded, NSString * title, NSArray *details))completionBlock
{
    NSError * error;
    NSString * urlString = @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json";
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(!error)
        {
            NSError * jsonError = nil;
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
            NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *factDetails = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            if (jsonError) {
                completionBlock(NO, @"", nil);
            }
            else {
                JsonParser * parser = [[JsonParser alloc] init];
                NSMutableArray * rows = [parser parseData:[factDetails valueForKey:@"rows"]];
                NSString * title = [factDetails valueForKey:@"title"];
                completionBlock(YES,title,rows);
            }
        }
        else
        {
            completionBlock(NO,@"",nil);
        }
    
    
    }];
}

-(void)downloadImage:(NSString *)urlString completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    if(urlString.length > 0)
    {
        NSLog(@"URL String = %@",urlString);
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
        {
            if (!error)
            {
                data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                UIImage *image = [[UIImage alloc] initWithData:data];
                completionBlock(YES,image);
            }
            else
            {
                completionBlock(NO,nil);
            }
        }];

    }
    else
    {
        completionBlock(NO,nil);
    }

}

@end
