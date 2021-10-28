//
//  CyanView.m
//  Responder
//
//  Created by jianqin_ruan on 2021/10/28.
//

#import "CyanView.h"

@implementation CyanView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.cyanColor;
        self.restorationIdentifier = @"CyanView";

    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"kk | touchesBegan : %@",self.restorationIdentifier);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"kk | touchesMoved : %@",self.restorationIdentifier);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"kk | touchesEnded : %@",self.restorationIdentifier);

}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"kk | touchesCancelled : %@",self.restorationIdentifier);
}

@end
