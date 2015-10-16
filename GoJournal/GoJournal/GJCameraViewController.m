//
//  GJCameraViewController.m
//  GoJournal
//
//  Created by Varindra Hart on 10/15/15.
//  Copyright © 2015 Elber Carneiro. All rights reserved.
//

#import "GJCameraViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface GJCameraViewController ()<CLLocationManagerDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation GJCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLocationManager];
    
    // Do any additional setup after loading the view.
}

- (void)setUpLocationManager{
    
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
            [self.locationManager requestAlwaysAuthorization];
        }
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        [self.locationManager startUpdatingLocation];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
