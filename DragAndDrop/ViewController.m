//
//  ViewController.m
//  DragAndDrop
//
//  Created by EnzoF on 31.08.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import "ViewController.h"
#import "BoardView.h"

@interface ViewController ()
@property (strong, nonatomic) BoardView *boardView;

//CurrentTouchDraught
@property (assign, nonatomic) CGPoint previousCenterDraught;
@property (strong, nonatomic) UIView *currentDraught;

@end

@implementation ViewController
- (void)viewDidLoad {
        [super viewDidLoad];
    self.boardView = [[BoardView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.boardView];
    
    self.boardView.autoresizingMask =   UIViewAutoresizingFlexibleLeftMargin    |
                                        UIViewAutoresizingFlexibleRightMargin   |
                                        UIViewAutoresizingFlexibleTopMargin     |
                                        UIViewAutoresizingFlexibleBottomMargin;

    [self.boardView createDraughts:BoardViewDraughtRedColor];
    [self.boardView createDraughts:BoardViewDraughtYellowColor];
}

#pragma mark -Touches-
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    CGPoint touchPoint = [self touchPoint:touches locationInView:self.boardView];
    UIView *currentView;
    currentView = [self searchDeepestViewFromArray:self.boardView.mArrayRedDraughts contentPoint:touchPoint fromView:self.boardView];
    if(!currentView)
    {
        currentView = [self searchDeepestViewFromArray:self.boardView.mArrayYellowDraughts contentPoint:touchPoint fromView:self.boardView];
    }
    if(currentView)
    {
            self.currentDraught = currentView;
            self.previousCenterDraught = currentView.center;
        NSLog(@"previousCentre %@",NSStringFromCGPoint(self.previousCenterDraught));
        [UIView animateWithDuration:0.3f
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.currentDraught.transform = CGAffineTransformMakeScale(2.f, 2.f);
                             self.currentDraught.center = touchPoint;
        
                        }
                         completion:^(BOOL finished){
                         }];
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    CGPoint touchPoint = [self touchPoint:touches locationInView:self.boardView];
    if(self.currentDraught != nil)
    {
        [UIView animateWithDuration:0.1f
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.currentDraught.center = touchPoint;
                             self.currentDraught.alpha = 0.5f;
                             
                         }
                         completion:^(BOOL finished){
                             
                             
                         }];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [self touchesFihishWithTouches:touches];
    NSLog(@"touchesEnded");
}
- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
   [self touchesFihishWithTouches:touches];
    NSLog(@"touchesCancelled");
}


#pragma mark -metods-
-(void)touchesFihishWithTouches:(NSSet<UITouch *> *)touches{
    CGPoint totalCenterDraught = self.previousCenterDraught;
    CGPoint touchPoint = [self touchPoint:touches locationInView:self.boardView];
    UIView *currentBlackSquareView = [self searchLocalViewFromArray:self.boardView.mArrayBlackSquare contentPoint:touchPoint exceptView:self.currentDraught];
    NSLog(@"previousCentre  in touchesFihishWithTouches %@",NSStringFromCGPoint(self.previousCenterDraught));
    
    //UIView *viewRect = nil;
    if(currentBlackSquareView)
    {
        if(![self searchLocalViewFromArray:self.boardView.mArrayYellowDraughts contentPoint:touchPoint exceptView:self.currentDraught])
        {
            if(![self searchLocalViewFromArray:self.boardView.mArrayRedDraughts contentPoint:touchPoint exceptView:self.currentDraught])
            {
                totalCenterDraught = currentBlackSquareView.center;
            }
        }
    }

    [UIView animateWithDuration:0.5f animations:^{
        self.currentDraught.transform = CGAffineTransformIdentity;
        self.currentDraught.alpha = 1.f;
     //   [self searchViewFromArray:self.boardView.mArrayBlackSquare contentPoint:touchPoint];
        self.currentDraught.center = totalCenterDraught;
    }];
    
    NSLog(@"previousCentre  in touchesFihishWithTouches after Animation %@",NSStringFromCGPoint(self.previousCenterDraught));
    //self.currentDraught = nil;
}

-(CGPoint)touchPoint:(NSSet<UITouch *> *)touches locationInView:(UIView*)view{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:view];
}


-(nullable UIView*)searchLocalViewFromArray:(NSMutableArray*)maArrayViews contentPoint:(CGPoint)contentPoint exceptView:(nullable UIView*)exceptView{
    UIView *totalView = nil;
    for (UIView *currentView in maArrayViews)
    {
        if(CGRectContainsPoint(currentView.frame, contentPoint))
        {
            
            if(![currentView isEqual:exceptView])
            {
                totalView = currentView;
                break;
            }
        }
    }
    return totalView;
}

-(nullable UIView*)searchDeepestViewFromArray:(NSMutableArray*)maArrayDraughts contentPoint:(CGPoint)contentPoint fromView:(UIView*)fromView{
    UIView *touchView = [fromView hitTest:contentPoint withEvent:nil];
    UIView *totalView = nil;
    for (UIView *view in maArrayDraughts)
    {
        if([view isEqual:touchView])
        {
            totalView = view;
            break;
        }
    }
    return totalView;
}
@end
