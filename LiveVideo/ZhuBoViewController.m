//
//  ZhuBoViewController.m
//  LiveVideo
//
//  Created by apple on 16/8/29.
//  Copyright © 2016年 Liancheng. All rights reserved.
//

#import "ZhuBoViewController.h"
#import <AVFoundation/AVFoundation.h>
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ZhuBoViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic,strong)AVCaptureSession *session;
@property (nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer;


@end

@implementation ZhuBoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    NSError *error = nil;
    self.session = [[AVCaptureSession alloc]init];
    //设置采集的质量，此处为中等的
    self.session.sessionPreset = AVCaptureSessionPresetMedium;
    //AVCaptureDevice：输入设备，包括麦克风、摄像头，通过该对象可以设置物理设备的一些属性（例如相机聚焦、白平衡、闪光、手电筒等）。
    //获取当前的摄像头
    AVCaptureDevice * device = [self cameraWithPosition:AVCaptureDevicePositionFront];
    //获取输入设备
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        //此处提示用户
        NSLog(@"%@",error);
    }
    //添加输入设备
    if ([_session canAddInput:input]) {
        [self.session addInput:input];
    }
    //获取输出设备
    AVCaptureVideoDataOutput * output = [[AVCaptureVideoDataOutput alloc]init];
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    [output setSampleBufferDelegate:self queue:queue];
    

}

//选择是前置摄像头还是后置摄像头
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray * arr = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice * device in arr) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//判断设备是否有摄像头
- (BOOL)isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

//判断前置摄像头是否可用
- (BOOL)isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

//判断后置摄像头是否可用
- (BOOL)isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
