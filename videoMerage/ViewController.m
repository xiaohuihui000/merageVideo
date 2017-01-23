//
//  ViewController.m
//  videoMerage
//
//  Created by chenguanghui on 17/1/3.
//  Copyright © 2017年 chenguanghui. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *videoArray = @[@"/Users/cgh/Desktop/2.mp4",@"/Users/cgh/Desktop/2.mp4"];
    
    /// 创建可变的构成
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    
    /// 取出 音视频 轨道
    
    AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    
    
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    
    /// 总时间
    CMTime totalDuration = kCMTimeZero;
    
    for (int i = 0; i < videoArray.count; i++) {
        AVAsset *asset = [AVAsset assetWithURL:[NSURL fileURLWithPath:videoArray[i]]];
        
        [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration) ofTrack:[[asset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:totalDuration error:nil];
        
        [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration) ofTrack:[[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:totalDuration error:nil];
        
        totalDuration = CMTimeAdd(asset.duration, totalDuration);
    }
    
    /// 合成文件路径
    NSString *path = @"/Users/cgh/Desktop/合成的.mp4";
    
    /// 导出
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetPassthrough];
    exporter.outputURL = [NSURL fileURLWithPath:path];
    exporter.outputFileType = AVFileTypeMPEG4;
    exporter.shouldOptimizeForNetworkUse = YES;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        NSLog(@"完成");
    }];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end















































