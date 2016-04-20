//
//  DNNetworking.h
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"


//完成部分(0.0~1.0)    完成字节数           总字节数         本地完成情况(44% completed)
//fractionCompleted, completedUnitCount, totalUnitCount, localizedDescription

typedef void (^DNSuccessBlock)(id obj);
typedef void (^DNFailureBlock)(NSError *error);
typedef void (^DNProgressBlock)(NSProgress *progress);
typedef void (^DNDownloadBlock)(NSURL *filePath, NSError *error);


@interface DNNetworking : NSObject

/**
 *  设置全局域名
 *
 *  @param baseUrl 全局域名
 */
+ (void)updateBaseUrl:(NSString *)baseUrl;

/**
 *  网络监测
 */
+ (void)netWorkReachability;

/**
 *  GET请求
 *
 *  @param urlString  请求链接
 *  @param success    请求结果
 *  @param failure    失败原因
 */
+ (void)getWithURLString:(NSString *)urlString success:(DNSuccessBlock)success failure:(DNFailureBlock)failure;

/**
 *  GET请求（参数）
 *
 *  @param urlString  请求链接
 *  @param parameters 请求参数
 *  @param success    请求结果
 *  @param failure    失败原因
 */
+ (void)getWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(DNSuccessBlock)success failure:(DNFailureBlock)failure;

/**
 *  GET请求（参数+进度）
 *
 *  @param urlString  请求链接
 *  @param parameters 请求参数
 *  @param progress   请求进度
 *  @param success    请求结果
 *  @param failure    失败原因
 */
+ (void)getWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters progress:(DNProgressBlock)progress success:(DNSuccessBlock)success failure:(DNFailureBlock)failure;

/**
 *  POST请求数据
 *
 *  @param urlString  请求链接
 *  @param parameters 请求参数
 *  @param success    请求结果
 *  @param failure    失败原因
 */
+ (void)postWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(DNSuccessBlock)success failure:(DNFailureBlock)failure;

/**
 *  POST上传图片（image数据）
 *
 *  @param urlString  请求链接
 *  @param parameters 请求参数
 *  @param data       图片image
 *  @param progress   请求进度
 *  @param success    请求结果
 *  @param failure    失败原因
 */
+ (void)postWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters image:(UIImage *)image progress:(DNProgressBlock)progress success:(DNSuccessBlock)success failure:(DNFailureBlock)failure;

/**
 *  POST上传图片（data数据）
 *
 *  @param urlString  请求链接
 *  @param parameters 请求参数
 *  @param data       图片data
 *  @param progress   请求进度
 *  @param success    请求结果
 *  @param failure    失败原因
 */
+ (void)postWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters imageData:(NSData*)data progress:(DNProgressBlock)progress success:(DNSuccessBlock)success failure:(DNFailureBlock)failure;

/**
 *  POST上传多张图片
 *
 *  @param urlString  请求链接
 *  @param parameters 请求参数
 *  @param images     图片数组
 *  @param progress   请求进度
 *  @param success    请求结果
 *  @param failure    失败原因
 */
+ (void)postWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters images:(NSArray *)images progress:(DNProgressBlock)progress success:(DNSuccessBlock)success failure:(DNFailureBlock)failure;

/**
 *  POST上传文件
 *
 *  @param urlString  请求链接
 *  @param parameters 请求参数
 *  @param data       文件
 *  @param type       类型
 *  @param progress   请求进度
 *  @param success    请求结果
 *  @param failure    失败原因
 */
+ (void)postWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters data:(NSData*)data mimeType:(NSString *)type progress:(DNProgressBlock)progress success:(DNSuccessBlock)success failure:(DNFailureBlock)failure;

/**
 *  POST上传视频
 *
 *  @param urlString  请求链接
 *  @param parameters 请求参数
 *  @param data       视频data
 *  @param img        logo
 *  @param progress   请求进度
 *  @param success    请求结果
 *  @param failure    失败原因
 */
+ (void)postWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters Data:(NSData*)data movieLogoImage:(UIImage *)img progress:(DNProgressBlock)progress success:(DNSuccessBlock)success failure:(DNFailureBlock)failure;

/**
 *  下载文件
 *
 *  @param urlString 下载链接
 *  @param progress  请求进度
 *  @param result    返回结果
 */
+ (void)downloadFileWithURLString:(NSString *)urlString progress:(DNProgressBlock)progress result:(DNDownloadBlock)result;

@end
