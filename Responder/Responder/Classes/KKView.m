//
//  KKView.m
//  Responder
//
//  Created by jianqin_ruan on 2021/10/27.
//

#import "KKView.h"

@implementation KKView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"kk | identifier : %@", self.restorationIdentifier);
}

@end
