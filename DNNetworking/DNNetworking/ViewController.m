//
//  ViewController.m
//  DNNetworking
//
//  Created by mainone on 16/4/20.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "ViewController.h"
#import "DNNetworking.h"

#define GETURL @"api/app/service.php?action=appMouldNavInfo"
#define POSTURL @"api/app/service.php"
#define IMAGEURL @"http://pic32.nipic.com/20130829/12906030_124355855000_2.png"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self getRequest];
//    [self postRequest];
//    [self downloadImage];
}

- (void)getRequest {
    [DNNetworking getWithURLString:GETURL success:^(id obj) {
        NSLog(@"get请求的到的信息:%@",obj);
    } failure:^(NSError *error) {
        NSLog(@"get请求的错误信息:%@",error);
    }];
}

- (void)postRequest {
    NSDictionary *para = @{
                            @"action":@"appMouldNavInfo"
                           };
    [DNNetworking postWithURLString:POSTURL parameters:para success:^(id obj) {
        NSLog(@"post返回的到的信息:%@",obj);
    } failure:^(NSError *error) {
        NSLog(@"post返回的错误信息:%@",error);
    }];
}

- (void)upImage {
    UIImage * upImage = nil;//要上传的图片
    NSDictionary *dic = @{
                            @"token":@"用户的token"
                          };
    [DNNetworking postWithURLString:@"上传链接" parameters:dic image:upImage progress:^(NSProgress *progress) {
        NSLog(@"上传图片的进度:%@",progress.localizedDescription);
    } success:^(id obj) {
        NSLog(@"post返回的到的信息:%@",obj);
    } failure:^(NSError *error) {
        NSLog(@"post返回的错误信息:%@",error);
    }];
}

- (void)downloadImage {
    [DNNetworking downloadFileWithURLString:IMAGEURL progress:^(NSProgress *progress) {
        NSLog(@"下载图片的进度:%@",progress.localizedDescription);
    } result:^(NSURL *filePath, NSError *error) {
        if (filePath) {
            NSLog(@"下载的路径:%@",[filePath absoluteString]);
            
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]]];
        }
        if (error) {
            NSLog(@"下载失败的原因:%@",error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
