//
//  MyWindow.m
//  Responder
//
//  Created by jianqin_ruan on 2021/10/28.
//

#import "MyWindow.h"

@implementation MyWindow

- (void)sendEvent:(UIEvent *)event {
    // 窗口发送事件到event里的UITouch对象里面的view(最佳响应者)
//    NSSet<UITouch *> *touches = event.allTouches;
//    for (UITouch *touch in touches) {
//        NSLog(@"kk | hit-tested view : %@",touch.view);
//    }
    [super sendEvent:event];
}

@end
