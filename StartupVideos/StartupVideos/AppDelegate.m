//
//  AppDelegate.m
//  StartupVideos
//
//  Created by Sheehan Alam on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import <Parse/Parse.h>


@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [TestFlight takeOff:@"20ef7722d1516e832525e0e0f851ad54_MTAzMjY2MjAxMi0wNi0yNCAyMTozOTozMS4wNzU3NTI"];
    [Parse setApplicationId:@"0a2K2UkkPupVi9VbKwJsixINaaqNXRqYmhi6usR1"
                  clientKey:@"CZW3aaXhi3WAXZXy69hJ0BRUrNwzqBao6v8GOXB4"];
    
    // Use the product identifier from iTunes to register a handler.
    [PFPurchase addObserverForProduct:@"Pro" block:^(SKPaymentTransaction *transaction) {
        // Write business logic that should run once this product is purchased.
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"proPackage"];
        [self.adWhirlView removeFromSuperview];
        
    }];
    
    homeViewController = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
    _homeNavController = [[UINavigationController alloc]initWithRootViewController:homeViewController];

   
    
    
    self.window.rootViewController = _homeNavController;
    
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"proPackage"]) {
        
        _adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
        [self.window.rootViewController.view addSubview:_adWhirlView];
    }
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Adwhirl delegate methods
- (NSString *)adWhirlApplicationKey {
    return @"a2b7c6384c664fca85a6c9510986ccae";
}

- (UIViewController *)viewControllerForPresentingModalView {
    return self.window.rootViewController;
}

- (void)adWhirlDidReceiveAd:(AdWhirlView *)adWhirlView {
    [UIView beginAnimations:@"AdWhirlDelegate.adWhirlDidReceiveAd:"
                    context:nil];
    
    [UIView setAnimationDuration:0.7];
    
    CGSize adSize = [adWhirlView actualAdSize];
    CGRect newFrame = adWhirlView.frame;
    
    newFrame.size = adSize;
    newFrame.origin.x = (320 - adSize.width)/ 2;
    newFrame.origin.y = (480 - adSize.height);
    
    adWhirlView.frame = newFrame;
    
    [UIView commitAnimations];
}


@end
