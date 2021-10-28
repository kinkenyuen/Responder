//
//  MyTableView.m
//  Responder
//
//  Created by jianqin_ruan on 2021/10/28.
//

#import "MyTableView.h"

@implementation MyTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.restorationIdentifier = @"MyTableView";
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

@end
