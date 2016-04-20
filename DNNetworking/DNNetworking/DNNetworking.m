//
//  DNNetworking.m
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNNetworking.h"
#import "AFNetworking.h"


#ifdef DEBUG
#define DNNetLog(...) NSLog(__VA_ARGS__)
#else
#define DNNetLog(...)
#endif

static NSString *privateNetworkBaseUrl = nil;

@implementation DNNetworking

+ (void)netWorkReachability{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown://未知信号
            {
                DNNetLog(@"未知信号");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN://手机信号
            {
                DNNetLog(@"手机信号");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi://WiFi信号
            {
                DNNetLog(@"WiFi信号");
                break;
            }
            case AFNetworkReachabilityStatusNotReachable://没有信号
            {
                DNNetLog(@"没有信号");
                break;
            }
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (void)updateBaseUrl:(NSString *)baseUrl {
    privateNetworkBaseUrl = baseUrl;
}

+ (NSString *)baseUrl {
    return privateNetworkBaseUrl;
}

+ (void)getWithURLString:(NSString *)urlString success:(DNSuccessBlock)success failure:(DNFailureBlock)failure {
    [self getWithURLString:urlString parameters:nil progress:^(NSProgress *progress) {
        
    } success:success failure:failure];
}

+ (void)getWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(DNSuccessBlock)success failure:(DNFailureBlock)failure {
    [self getWithURLString:urlString parameters:parameters progress:^(NSProgress *progress) {
        
    } success:success failure:failure];
}

+ (void)getWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters progress:(DNProgressBlock)progress success:(DNSuccessBlock)success failure:(DNFailureBlock)failure {
    DNNetLog(@"GET请求的链接--------------------->%@",urlString);
    AFHTTPSessionManager *session = nil;
    if ([self baseUrl] != nil && ![urlString hasPrefix:@"http://"] && ![urlString hasPrefix:@"https://"]) {
        session = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
    }else {
        DNNetLog(@"全域名");
        session = [AFHTTPSessionManager manager];
    }
//    [session.requestSerializer setValue:@"" forHTTPHeaderField:@""];
    
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    session.requestSerializer.timeoutInterval = 20;
    [session GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
//        DNNetLog(@"GET请求到的数据===>%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
//        DNNetLog(@"GET失败原因===>%@",error);
    }];
}

+ (void)postWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(DNSuccessBlock)success failure:(DNFailureBlock)failure {
    [self postWithURLString:urlString parameters:parameters data:nil mimeType:nil progress:^(NSProgress *progress) {
        
    } success:success failure:failure];
}

+ (void)postWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters image:(UIImage *)image progress:(DNProgressBlock)progress success:(DNSuccessBlock)success failure:(DNFailureBlock)failure {
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [self postWithURLString:urlString parameters:parameters data:imageData mimeType:@"image/jpeg" progress:progress success:success failure:failure];
}

+ (void)postWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters imageData:(NSData*)data progress:(DNProgressBlock)progress success:(DNSuccessBlock)success failure:(DNFailureBlock)failure {
    [self postWithURLString:urlString parameters:parameters data:data mimeType:@"image/jpeg" progress:progress success:success failure:failure];
}

+ (void)postWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters images:(NSArray *)images progress:(DNProgressBlock)progress success:(DNSuccessBlock)success failure:(DNFailureBlock)failure {
     DNNetLog(@"POST请求的链接--------------------->%@",urlString);
    AFHTTPSessionManager *session = nil;
    if ([self baseUrl] != nil && ![urlString hasPrefix:@"http://"] && ![urlString hasPrefix:@"https://"]) {
        session = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
    }else {
        DNNetLog(@"全域名");
        session = [AFHTTPSessionManager manager];
    }
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    [session POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (images) {
            for (UIImage *image in images) {
                NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
                [formData appendPartWithFileData :imgData name:[NSString stringWithFormat:@"%d",(int)[images indexOfObject:image]] fileName:[NSString stringWithFormat:@"%d.png",(int)[images indexOfObject:image]] mimeType:@"image/jpeg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
//        DNNetLog(@"POST请求到的数据===>%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
//        DNNetLog(@"POST失败原因===>%@",error);
    }];
}

+ (void)postWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters data:(NSData*)data mimeType:(NSString *)type progress:(DNProgressBlock)progress success:(DNSuccessBlock)success failure:(DNFailureBlock)failure {
    DNNetLog(@"POST请求的链接--------------------->%@",urlString);
    AFHTTPSessionManager *session = nil;
    if ([self baseUrl] != nil && ![urlString hasPrefix:@"http://"] && ![urlString hasPrefix:@"https://"]) {
        session = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
    }else {
        DNNetLog(@"全域名");
        session = [AFHTTPSessionManager manager];
    }
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    [session POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (data) {
            [formData appendPartWithFileData:data name:@"data" fileName:@"data" mimeType:type];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
//        DNNetLog(@"POST请求到的数据===>%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
//        DNNetLog(@"POST失败原因===>%@",error);
    }];
}

+ (void)postWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters Data:(NSData*)data movieLogoImage:(UIImage *)img progress:(DNProgressBlock)progress success:(DNSuccessBlock)success failure:(DNFailureBlock)failure {
    DNNetLog(@"上传视频的链接-------------------->%@",urlString);
    AFHTTPSessionManager *session = nil;
    if ([self baseUrl] != nil && ![urlString hasPrefix:@"http://"] && ![urlString hasPrefix:@"https://"]) {
        session = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
    }else {
        DNNetLog(@"全域名");
        session = [AFHTTPSessionManager manager];
    }
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    [session POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (data) {
            [formData appendPartWithFileData:data name:@"data" fileName:@"data" mimeType:@"video/x-sgi-movie"];
        }
        if (img) {
            NSData *imgData = UIImageJPEGRepresentation(img, 1.0);
            [formData appendPartWithFileData:imgData name:@"attach" fileName:@"attach.jpg" mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
//        DNNetLog(@"上传视频返回数据===>%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
//        DNNetLog(@"上传视频失败原因===>%@",error);
    }];
}

+ (void)downloadFileWithURLString:(NSString *)urlString progress:(DNProgressBlock)progress result:(DNDownloadBlock)result {
    DNNetLog(@"文件下载链接-------------------->%@",urlString);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];//默认存到 NSDocumentDirectory
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        result(filePath, error);
    }];
    [downloadTask resume];
}

@end
