//
//  BlueView.m
//  Responder
//
//  Created by jianqin_ruan on 2021/10/28.
//

#import "BlueView.h"

@implementation BlueView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.blueColor;
        self.restorationIdentifier = @"BlueView";
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
