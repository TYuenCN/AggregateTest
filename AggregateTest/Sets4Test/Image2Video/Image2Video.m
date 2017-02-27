//
//  Image2Video.m
//  AggregateTest
//
//  Created by 袁峥 on 17/2/24.
//  Copyright © 2017年 Yuen. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <VideoToolbox/VideoToolbox.h>
#import <UIKit/UIKit.h>
#import "Image2Video.h"

@interface Image2Video ()
@property(nonatomic, strong)NSMutableArray *imageArr;
@property(nonatomic, strong)NSString  *theVideoPath;
@property(nonatomic, strong)AVAssetWriter *videoWriter;
@property(nonatomic, strong)AVAssetWriterInput *writerInput;
@end

@implementation Image2Video
VTCompressionSessionRef EncodingSession;
-(void)testCompressionSession
{
    NSLog(@"开始");
    self.imageArr = @[
                      [UIImage imageNamed:@"1.tiff"],
                      [UIImage imageNamed:@"2.tiff"],
                      [UIImage imageNamed:@"3.tiff"],
                      [UIImage imageNamed:@"4.tiff"],
                      [UIImage imageNamed:@"5.tiff"],
                      [UIImage imageNamed:@"6.tiff"],
                      [UIImage imageNamed:@"7.tiff"],
                      [UIImage imageNamed:@"8.tiff"]
                      ];
    
    //NSString *moviePath = [[NSBundle mainBundle]pathForResource:@"Movie" ofType:@"mov"];
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *moviePath =[[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",@"2016全球三大超跑宣传片_超清"]];
    
    self.theVideoPath=moviePath;
    
    CGSize size = CGSizeMake(320,400);//定义视频的大小
    
    //[self writeImages:_imageArr ToMovieAtPath:moviePath withSize:size  inDuration:4 byFPS:30];//第2中方法
    
    NSError *error =nil;
    unlink([moviePath UTF8String]);
    NSLog(@"path->%@",moviePath);
    
    //—-initialize compression engine
    self.videoWriter =[[AVAssetWriter alloc]initWithURL:[NSURL fileURLWithPath:moviePath]fileType:AVFileTypeQuickTimeMovie error:&error];
    
    NSParameterAssert(self.videoWriter);
    
    if(error)
        NSLog(@"error =%@", [error localizedDescription]);
    
    NSDictionary *videoSettings =[NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264,AVVideoCodecKey,
                                  [NSNumber numberWithInt:size.width],AVVideoWidthKey,
                                  [NSNumber numberWithInt:size.height],AVVideoHeightKey,nil];
    
    self.writerInput =[AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:nil];
    
//    NSDictionary*sourcePixelBufferAttributesDictionary =[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_32ARGB],kCVPixelBufferPixelFormatTypeKey,nil];
//    
//    AVAssetWriterInputPixelBufferAdaptor *adaptor =[AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput
//                                                    
//                                                                                                                    sourcePixelBufferAttributes:sourcePixelBufferAttributesDictionary];
//    
    NSParameterAssert(self.writerInput);
    NSParameterAssert([self.videoWriter canAddInput:self.writerInput]);
    if ([self.videoWriter canAddInput:self.writerInput])
        NSLog(@"11111");
    else
        NSLog(@"22222");
    
    [self.videoWriter addInput:self.writerInput];
    [self.videoWriter startWriting];
    [self.videoWriter startSessionAtSourceTime:kCMTimeZero];
    
    //合成多张图片为一个视频文件
    dispatch_queue_t dispatchQueue =dispatch_queue_create("mediaInputQueue",NULL);
    
    int __block frame =0;
    
    
    
    OSStatus status = VTCompressionSessionCreate(NULL, 320, 400, kCMVideoCodecType_H264, NULL, NULL, NULL, didCompressH264,(__bridge void *)(self),  &EncodingSession);
    if (status != 0)
    {
        NSLog(@"H264: Unable to create a H264 session");
        return ;
    }
    
    VTSessionSetProperty(EncodingSession, kVTCompressionPropertyKey_RealTime, kCFBooleanTrue);
    VTSessionSetProperty(EncodingSession, kVTCompressionPropertyKey_ProfileLevel, kVTProfileLevel_H264_Baseline_4_1);
    
    SInt32 bitRate = 320*400*50;
    CFNumberRef ref = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &bitRate);
    VTSessionSetProperty(EncodingSession, kVTCompressionPropertyKey_AverageBitRate, ref);
    CFRelease(ref);
    
    int frameInterval = 10; //关键帧间隔
    CFNumberRef  frameIntervalRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &frameInterval);
    VTSessionSetProperty(EncodingSession, kVTCompressionPropertyKey_MaxKeyFrameInterval,frameIntervalRef);
    CFRelease(frameIntervalRef);
    // Tell the encoder to start encoding
    VTCompressionSessionPrepareToEncodeFrames(EncodingSession);
    
    
    
    
    [self.writerInput requestMediaDataWhenReadyOnQueue:dispatchQueue usingBlock:^{
        if ([self.writerInput isReadyForMoreMediaData]) {
            [self compressFrame];
//            while (++frame < [self.imageArr count]*10) {
//                int idx =frame/10;
//                UIImage *img = [self.imageArr objectAtIndex:idx];
//                CVImageBufferRef imageBuffer = (CVImageBufferRef)[self pixelBufferFromCGImage:img.CGImage size:size];
//                
//                CMTime presentationTimeStamp = CMTimeMake(fff, 1000);
//                VTEncodeInfoFlags flags;
//                OSStatus statusCode = VTCompressionSessionEncodeFrame(EncodingSession, imageBuffer, presentationTimeStamp, kCMTimeInvalid, NULL, NULL, &flags);
//                if (statusCode != noErr)
//                {
//                    if (EncodingSession!=nil||EncodingSession!=NULL)
//                    {
//                        VTCompressionSessionInvalidate(EncodingSession);
//                        CFRelease(EncodingSession);
//                        //EncodingSession = NULL;
//                        return;
//                    }
//                }
//            }
        }
    }];
}

int fff = 0;
bool nxOK = true;

- (void)compressFrame
{
    if (++fff < [self.imageArr count]*2) {
        NSLog(@"fff=%d", fff);
        int idx =fff/2;
        UIImage *img = [self.imageArr objectAtIndex:idx];
        CVImageBufferRef imageBuffer = (CVImageBufferRef)[self pixelBufferFromCGImage:img.CGImage size:CGSizeMake(320,400)];
        
        CMTime presentationTimeStamp = CMTimeMake(fff, 25);
        VTEncodeInfoFlags flags;
        OSStatus statusCode = VTCompressionSessionEncodeFrame(EncodingSession, imageBuffer, presentationTimeStamp, kCMTimeInvalid, NULL, NULL, &flags);
        if (statusCode != noErr)
        {
            if (EncodingSession!=nil||EncodingSession!=NULL)
            {
                VTCompressionSessionInvalidate(EncodingSession);
                CFRelease(EncodingSession);
                //EncodingSession = NULL;
                return;
            }
        }
        
    }
}

int ccc = 0;
void didCompressH264(void *outputCallbackRefCon, void *sourceFrameRefCon, OSStatus status, VTEncodeInfoFlags infoFlags,
                     CMSampleBufferRef sampleBuffer )
{
    Image2Video* encoder = (__bridge Image2Video*)outputCallbackRefCon;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [encoder.writerInput markAsFinished];
            [encoder.videoWriter finishWriting];
        });
    });
//    if(++ccc >=[encoder.imageArr count]*10)
//    {
//        [encoder.writerInput markAsFinished];
//        [encoder.videoWriter finishWriting];
//    }
    [encoder.writerInput appendSampleBuffer:sampleBuffer];
    nxOK = true;
    NSLog(@"ccc=%d", ++ccc);
//    [encoder compressFrame];
}

- (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)image size:(CGSize)size{
    
    
    
    
    
    
    NSDictionary *options =[NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithBool:YES],kCVPixelBufferCGImageCompatibilityKey,
                            [NSNumber numberWithBool:YES],kCVPixelBufferCGBitmapContextCompatibilityKey,nil];
    
    CVPixelBufferRef pxbuffer =NULL;
    
    CVReturn status2 =CVPixelBufferCreate(kCFAllocatorDefault,size.width,size.height,kCVPixelFormatType_32ARGB,(__bridge CFDictionaryRef) options,&pxbuffer);
    
    NSParameterAssert(status2 ==kCVReturnSuccess && pxbuffer !=NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer,0);
    
    void *pxdata =CVPixelBufferGetBaseAddress(pxbuffer);
    
    NSParameterAssert(pxdata !=NULL);
    
    CGColorSpaceRef rgbColorSpace=CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context =CGBitmapContextCreate(pxdata,size.width,size.height,8,4*size.width,rgbColorSpace,kCGImageAlphaPremultipliedFirst);
    
    NSParameterAssert(context);
    CGContextDrawImage(context,CGRectMake(0,0,320,400), image);
    
    CGColorSpaceRelease(rgbColorSpace);
    
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer,0);
    
    return pxbuffer;
}

@end
