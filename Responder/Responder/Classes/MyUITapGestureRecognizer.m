//
//  MyUITapGestureRecognizer.m
//  Responder
//
//  Created by jianqin_ruan on 2021/10/28.
//

#import "MyUITapGestureRecognizer.h"

@implementation MyUITapGestureRecognizer

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"kk | %s",__func__);
    [super touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"kk | %s",__func__);
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"kk | %s",__func__);
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"kk | %s",__func__);
    [super touchesCancelled:touches withEvent:event];
}

@end
