//
//  BoardView.h
//  DragAndDrop
//
//  Created by EnzoF on 31.08.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    BoardViewDraughtRedColor,
    BoardViewDraughtYellowColor
}BoardViewDraughtColor;
@interface BoardView : UIView

//@property (strong,nonatomic) UIView *boardView;
@property (strong,nonatomic) NSMutableArray<UIView*> *mArrayRedDraughts;
@property (strong,nonatomic) NSMutableArray<UIView*> *mArrayYellowDraughts;
@property (strong,nonatomic) NSMutableArray<UIView*> *mArrayBlackSquare;
@property (assign,nonatomic) CGFloat indentedBoardBoarderRect;
@property (assign,nonatomic) CGFloat indentedPlayingFieldRect;
@property (assign,nonatomic) CGFloat indentedDraught;
@property (assign,nonatomic) CGFloat boarderBoardWidth;
@property (assign,nonatomic) CGColorRef borderColor;

-(instancetype)initWithFrame:(CGRect)frame;
-(void)createDraughts:(BoardViewDraughtColor)boardViewDraughtColor;

@end
