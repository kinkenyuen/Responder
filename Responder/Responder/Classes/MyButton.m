//
//  MyButton.m
//  Responder
//
//  Created by jianqin_ruan on 2021/10/28.
//

#import "MyButton.h"

@implementation MyButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.restorationIdentifier = @"MyButton";
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"kk | touchesBegan : %@",self.restorationIdentifier);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"kk | touchesMoved : %@",self.restorationIdentifier);
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"kk | touchesEnded : %@",self.restorationIdentifier);
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"kk | touchesCancelled : %@",self.restorationIdentifier);
    [super touchesCancelled:touches withEvent:event];
}


- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"kk | beginTrackingWithTouch : %@", self.restorationIdentifier);
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"kk | continueTrackingWithTouch : %@", self.restorationIdentifier);
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"kk | endTrackingWithTouch : %@", self.restorationIdentifier);
    return [super endTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    NSLog(@"kk | cancelTrackingWithEvent : %@", self.restorationIdentifier);
    return [super cancelTrackingWithEvent:event];
}

@end
