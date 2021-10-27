# 使用Responders和Responder Chain来处理事件

 学习如何处理在应用程序中传递的事件

> 下面使用这样的译法
>
> Responder : 响应者
>
> Responder Chanin : 响应链

## 概览

应用程序通过使用响应者对象来接收和处理事件，一个响应者对象可以是任何UIResponder类或子类的实例，比如常见的UIView、UIViewController和UIApplication。响应者接收原始事件数据，必须处理该事件或将其转发给另一个响应者对象。当你的应用程序接收到一个事件时，UIKit会自动将该事件定向到最合适的响应者对象，即**第一响应者**

未处理的消息会沿着响应链从一个响应者传递到另一个响应者，下图展示了应用程序中的响应者，该应用程序的界面包含一个label、一个text field、一个button和两个background view，它还展示了事件是如何沿着响应链从一个响应者移动到下一个响应者

<div align="center">    
<img src="./imgs/1.png" width="75%" height="75%">
</div>

> 什么是next responder ？ 
>
> 当前响应者不能处理事件，传递给下一个处理的响应者对象

本例中，如果text field不处理事件，UIKit会将事件发送到text field的父UIView对象，然后到window的root view(在这里也是controller的root view)

在将事件转发给window之前，会先从root view转发到它所属的controller

如果window不能处理事件，UIKit将事件传递给UIApplication对象，或UIApplication对象的delegate（如果delegate是UIResponder的一个实例）

## 决定事件的第一响应者

这个过程就是在寻找最适合处理事件的第一响应者

| 事件类型     | 第一响应者                                 |
| ------------ | ------------------------------------------ |
| 触摸事件     | 触发发生的那个view                         |
| 按压事件     | The object that has focus (具有焦点的对象) |
| 摇晃         | 你或UIKit指定的对象                        |
| 远程控制事件 | 你或UIKit指定的对象                        |
| 编辑菜单信息 | 你或UIKit指定的对象                        |

> 与加速度计、陀螺仪和磁力计相关的运动事件不遵循响应链。相反，Core Motion直接将这些事件传递给指定的对象

UIControl类控件直接与它关联的target通信，当用户与控件交互时，控件向其target对象发送action消息

**action消息并不是事件，但它们仍然可以利用响应链**

**当控件的target对象为nil时，UIKit从target对象开始，遍历响应链，直到找到一个实现了对应action方法的对象**例如，UIKit编辑菜单使用这种行为来搜索实现名称为`cut:`， `copy:`，或`paste:`的方法的响应者对象

**手势识别器(Gesture recognizers)在它们的视图处理之前接收触摸和按压事件，如果一个视图的手势识别器不能识别一个触摸序列，UIKit会将触摸(touches)发送给视图。如果视图不处理触摸，UIKit就将它们传递到响应链上**

## 决定哪个响应者包含了一个Touch event

UIKit使用基于视图的`hit-testing`来确定触摸事件发生的位置。**具体来说，UIKit将触摸位置与视图层次结构中视图对象的边界(bounds)进行比较**。**使用UIView的`hitTest:withEvent:`方法遍历视图层次结构，寻找包含指定触摸的最深的子视图，它成为触摸事件的第一响应者**

> 如果一个触摸位置超出了视图的边界，那么hitTest:withEvent:方法会忽略该视图及其所有子视图
>
> 因此，当视图的clipsToBounds属性为NO时，该视图边界之外的子视图不会被返回，即使它们碰巧包含触摸

当触摸发生时，UIKit创建一个UITouch对象并将它与视图关联起来。当触摸位置或其他参数改变时，UIKit用新的信息更新相同的UITouch对象。**唯一不变的属性是视图。(即使当触摸位置移动到原始视图之外，触摸的视图属性中的值也不会改变。)当触摸结束时，UIKit释放UITouch对象**

### 关于hitTest:withEvent:方法

> Returns the farthest descendant of the receiver in the view hierarchy (including itself) that contains a specified point.

**假如有一个View，它里面有多个子View，在这个View上发生触摸时，会调用该方法在这个View的视图层次结构上递归查找一个最深的包含该触摸位置的子View，并返回该子View，也有可能返回自己**

```objective-c
- (UIView *)hitTest:(CGPoint)point 
          withEvent:(UIEvent *)event;
// points : 在当前view的坐标系统中的点
// event :  包含UITouch对象的UIEvent对象
```

这个方法通过调用每个子视图的`pointInside:withEvent:`方法来遍历视图层次结构，以确定哪个子视图应该接收一个触摸事件。如果`pointInside:withEvent:`返回YES，则同样遍历子视图的层次结构，直到找到包含指定point的最前面的视图。**如果一个视图不包含这个点，它的视图层次结构分支将被忽略。你很少需要自己调用这个方法，但你可以重写它让子视图隐藏触摸事件**

该方法忽略**隐藏的**、**禁用用户交互的**或**alpha值小于0.01**的视图对象

> This method does not take the view’s content into account when determining a hit. Thus, a view can still be returned even if the specified point is in a transparent portion of that view’s content.

该方法在确定point是否在子视图上时，不会考虑视图的内容。因此，即使指定的点位于视图内容的透明部分，仍然可以返回该视图

**位于接收器bounds之外的point永远不会被告知为命中，即使它们实际上位于接收器的子视图之一。如果当前视图的clipsToBounds属性被设置为NO，并且受影响的子视图超出了视图的边界，就会发生这种情况**

## 改变响应链

你可以通过重写响应者对象的nextResponder方法来更改响应链

许多UIKit类已经重写了这个属性的get方法并返回特定的对象，包括:

* UIView，如果这个view是视图控制器的root view，那么下一个响应者就是视图控制器；否则，下一个响应者就是view的super view
* UIViewController
    * 如果视图控制器的view是一个window的root view，那么下一个响应者就是Window对象
    * 如果视图控制器由另一个视图控制器呈现，下一个响应者就是`presenting`视图控制器
* UIWindow的下一个响应者是UIApplication对象
* UIApplication的下一响应者是app delegate，但仅当它是UIResponder的实例，并且它不是view、view controller和app对象本身

# ref

[Using Responders and the Responder Chain to Handle Events](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/using_responders_and_the_responder_chain_to_handle_events?language=objc)

[hitTest:withEvent:](https://developer.apple.com/documentation/uikit/uiview/1622469-hittest?language=objc)

