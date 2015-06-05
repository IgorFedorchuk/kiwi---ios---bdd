//
//  IFWebCore.m
//  RSS
//
//  Created by Igor Fedorchuk on 02/11/14.
//  Copyright (c) 2014 Igor Fedorchuk. All rights reserved.
//

#import "IFWebCore.h"
static NSURLSession *downloadImageSession;

@interface IFWebCore() <NSURLSessionDelegate>

@end

@implementation IFWebCore

+ (void)requestWithUrl:(NSURL *)url success:(SuccessBlock)success failure:(FailureBlock)failure
{
    if (url == nil)
    {
        if (failure)
        {
            failure(nil);
        }
    }
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (data && error == nil)
            {
                if (success)
                {
                    success(data);
                }
            }
            else
            {
                if (failure)
                {
                    failure(error);
                    NSLog(@"Error: %@", error);
                }
            }
        }];
    }];
    
    [downloadTask resume];
}

+ (void)requestWithUrl:(NSURL *)imageUrl imagePath:(NSString *)imagePath success:(SuccessImageRequestBlock)success
{
    if (imageUrl == nil || imagePath == nil)
    {
        if (success)
        {
            success(NO, nil);
        }
        return;
    }
    
    NSURLSessionDownloadTask *downloadPhotoTask = [[IFWebCore imageSessionWithDelegate:nil] downloadTaskWithURL:imageUrl completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *destinationUrl = [NSURL fileURLWithPath:imagePath];
        NSError *fileManagerError;
        [fileManager removeItemAtURL:destinationUrl error:&fileManagerError];
        [fileManager copyItemAtURL:location toURL:destinationUrl error:&fileManagerError];
        
        if (success)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (fileManagerError == nil)
                {
                    success(YES, imagePath);
                }
                else
                {
                    success(NO, nil);
                }
            }];
        }
    }];
    
    [downloadPhotoTask resume];
}

#pragma mark - Private

+ (NSURLSession *)imageSessionWithDelegate:(id<NSURLSessionDelegate>)delegate
{    
    if (downloadImageSession == nil)
    {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfig.HTTPMaximumConnectionsPerHost = 5;
        sessionConfig.timeoutIntervalForResource = 0;
        sessionConfig.timeoutIntervalForRequest = 0;
        downloadImageSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:delegate delegateQueue:nil];
    }
    
    return downloadImageSession;
}

@end
