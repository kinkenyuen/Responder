//
//  AppDelegate.m
//  Responder
//
//  Created by jianqin_ruan on 2021/10/27.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[MyWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = ViewController.new;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
