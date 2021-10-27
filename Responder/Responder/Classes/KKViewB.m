//
//  KKViewB.m
//  Responder
//
//  Created by jianqin_ruan on 2021/10/27.
//

#import "KKViewB.h"

@implementation KKViewB

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"kk | identifier : %@", self.restorationIdentifier);
}

// 点击穿透
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    return nil;
//}

@end
