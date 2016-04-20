# DNNetworking
对AFNetworking 3.0的封装
###功能介绍
对AFNetworking 3.0的网络请求的再次封装，使用起来也相对简单
本次封装主要包括了常用的网络状况监听，Get、POST请求，单张多张图片以及视频的上传，网络文件的下载等。

###相关配置
该工程使用的cocoapods管理，添加AFNetworking三方库

    pod 'AFNetworking', '~> 3.0'
    
###使用说明
1.引入头文件#import "DNNetworking.h"

2.实现相关请求代码

在AppDelegate中设置网络监听和全局域名（不设置全局域名也可以，会根据是否包含域名来匹配）

    //开启网络监控
    [DNNetworking netWorkReachability];
    
    //设置全局域名
    [DNNetworking updateBaseUrl:@"http://www.jiketanyou.com"];
    
GET请求

    - (void)getRequest {
        [DNNetworking getWithURLString:GETURL success:^(id obj) {
            NSLog(@"get请求的到的信息:%@",obj);
        } failure:^(NSError *error) {
            NSLog(@"get请求的错误信息:%@",error);
        }];
    }
    
POST请求

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


下载请求
  
    - (void)downloadImage {
        [DNNetworking downloadFileWithURLString:IMAGEURL progress:^(NSProgress *progress) {
            NSLog(@"下载图片的进度:%@",progress.localizedDescription);
        } result:^(NSURL *filePath, NSError *error) {
            if (filePath) {
                NSLog(@"下载的路径:%@",[filePath absoluteString]);
            }
            if (error) {
                NSLog(@"下载失败的原因:%@",error);
            }
        }];
    }

上传图片

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

