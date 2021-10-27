//
//  KKViewA.m
//  Responder
//
//  Created by jianqin_ruan on 2021/10/27.
//

#import "KKViewA.h"

@implementation KKViewA

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"kk | touchesBegan : %@", self.restorationIdentifier);
//    [[self nextResponder] touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"kk | touchesEnded : %@", self.restorationIdentifier);
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"kk | touchesCancelled : %@", self.restorationIdentifier);
}

@end
