//
//  HLComposeViewController.m
//  nvshen
//
//  Created by hoolang on 15/5/11.
//  Copyright (c) 2015年 Hoolang. All rights reserved.
//

#import "HLComposeViewController.h"
#import "DoImagePickerController.h"
@import Photos;

@interface HLComposeViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation HLComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏
    [self setupNav];

    [self setAlum];

    //添加相册
    //[self openAlbum];
}
/**
 添加相册
 */
- (void)openAlbum
{
    // 如果想自己写一个图片选择控制器，得利用AssetsLibrary.framework，利用这个框架可以获得手机上的所有相册图片
    // UIImagePickerControllerSourceTypePhotoLibrary > UIImagePickerControllerSourceTypeSavedPhotosAlbum
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)newOpenImagePickerController:(UIImagePickerControllerSourceType)type{
    
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController availableMediaTypesForSourceType:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
/**
 * 从UIImagePickerController选择完图片后就调用（拍照完毕或者选择相册图片完毕）
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // info中就包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 添加图片到photosView中
    //[self.photosView addPhoto:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}
/**
 设置导航栏
 */
- (void)setupNav{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    // 这个item不能点击(目前放在viewWillAppear就能显示disable下的主题)
    self.navigationItem.rightBarButtonItem.enabled = NO;}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAlum{
    
    DoImagePickerController *cont = [[DoImagePickerController alloc] initWithNibName:@"DoImagePickerController" bundle:nil];
    cont.delegate = self;
    cont.nResultType = DO_PICKER_RESULT_UIIMAGE;
    cont.nMaxCount = 1;
    //    if (_sgMaxCount.selectedSegmentIndex == 0)
    //        cont.nMaxCount = 1;
    //    else if (_sgMaxCount.selectedSegmentIndex == 1)
    //        cont.nMaxCount = 4;
    //    else if (_sgMaxCount.selectedSegmentIndex == 2)
    //    {
    //        cont.nMaxCount = DO_NO_LIMIT_SELECT;
    //        cont.nResultType = DO_PICKER_RESULT_ASSET;  // if you want to get lots photos, you'd better use this mode for memory!!!
    //    }
    
    //cont.nColumnCount = _sgColumnCount.selectedSegmentIndex + 2;
    cont.nColumnCount = 3;
    [self presentViewController:cont animated:YES completion:nil];
    

}


@end
