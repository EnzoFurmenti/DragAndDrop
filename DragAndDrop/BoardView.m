//
//  BoardView.m
//  DragAndDrop
//
//  Created by EnzoF on 31.08.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import "BoardView.h"
#import "Draught.h"

@interface BoardView()

@property (assign,nonatomic) CGRect playingFieldRect;

@end


@implementation BoardView

#pragma mark -initialization-
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.indentedBoardBoarderRect = 5.f;
        self.indentedPlayingFieldRect = 6.f;
        self.indentedDraught = 15.f;
        self.boarderBoardWidth = 3.f;
        self.borderColor = [UIColor blackColor].CGColor;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            self.indentedDraught = 10.f;
        }
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.indentedDraught = 20.f;
        }
        
        self.frame = [self createMaxSquareInCentreRectParentView:frame withIndented:self.indentedBoardBoarderRect];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = self.borderColor;
        self.layer.borderWidth = self.boarderBoardWidth;
        //self.boardView.tag = 20;
        
        self.playingFieldRect = [self createMaxSquareInCentreRectParentView:self.bounds withIndented:self.indentedPlayingFieldRect];
        CGFloat boardOriginX = CGRectGetMinX(self.playingFieldRect);
        CGFloat boardOriginY = CGRectGetMinY(self.playingFieldRect);
        CGFloat widthSquare =  CGRectGetWidth(self.playingFieldRect) / 8;
        CGFloat heightSquare = CGRectGetHeight(self.playingFieldRect) / 8;
        
        CGFloat x = 0.f;
        CGFloat y = 0.f;
        //NSInteger positionSquare = 1;
        
        for(int row = 1;row <= 8;row++)
        {
            int startColumn = row % 2 ? 2 : 1;
            for(int column = startColumn;column <= 8;column = column + 2)
            {
                x = boardOriginX + widthSquare * (column - 1);
                y = boardOriginY + heightSquare * (row - 1);
                CGRect r = CGRectMake(x, y, widthSquare, heightSquare);
                UIView *squareView = [self addAndGetSubViewWithRect:r withBGColor:[UIColor blackColor] onParentView:self];
                [self.mArrayBlackSquare addObject:squareView];
                squareView.tag = 100;
            }
        }
    }
    return self;
}

-(NSMutableArray*)mArrayRedDraughts{
    if(!_mArrayRedDraughts)
    {
        _mArrayRedDraughts = [[NSMutableArray alloc]init];
    }
    return _mArrayRedDraughts;
}

-(NSMutableArray*)mArrayYellowDraughts{
    if(!_mArrayYellowDraughts)
    {
        _mArrayYellowDraughts = [[NSMutableArray alloc]init];
    }
    return _mArrayYellowDraughts;
}

-(NSMutableArray*)mArrayBlackSquare{
    if(!_mArrayBlackSquare)
    {
        _mArrayBlackSquare = [[NSMutableArray alloc]init];
    }
    return _mArrayBlackSquare;
}

#pragma mark -metods-

-(UIView*)addAndGetSubViewWithRect:(CGRect)rect withBGColor:(UIColor*)color onParentView:(UIView*)parentView{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = color;
    if(parentView)
    {
        [parentView addSubview:view];
    }
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin   |
    UIViewAutoresizingFlexibleRightMargin  |
    UIViewAutoresizingFlexibleTopMargin    |
    UIViewAutoresizingFlexibleBottomMargin;
    return view;
}

- (CGRect)createMaxSquareInCentreRectParentView:(CGRect)rectView withIndented:(CGFloat)indended{
    if(!indended)
    {
        return rectView;
    }
    CGFloat rectViewMidX = CGRectGetMidX(rectView);
    CGFloat rectViewMidY = CGRectGetMidY(rectView);
    
    CGFloat widthRect;
    CGFloat heightRect;
    if(CGRectGetWidth(rectView) > CGRectGetHeight(rectView))
    {
        widthRect = CGRectGetHeight(rectView) - 2 * indended;
        heightRect = CGRectGetHeight(rectView) - 2 * indended;
    }
    else
    {
        widthRect = CGRectGetWidth(rectView) - 2 * indended;
        heightRect = CGRectGetWidth(rectView) - 2 * indended;
    }
    CGFloat rectOriginX = rectViewMidX - widthRect / 2;
    CGFloat rectOriginY = rectViewMidY - heightRect / 2;
    return CGRectMake(rectOriginX, rectOriginY, widthRect, heightRect);
}

- (void)createDraughts:(BoardViewDraughtColor)boardViewDraughtColor{
    BOOL redDraught = NO;
    if(boardViewDraughtColor == BoardViewDraughtRedColor)
    {
        redDraught = YES;
    }
    redDraught ? [self.mArrayRedDraughts removeAllObjects] : [self.mArrayYellowDraughts removeAllObjects];
    CGFloat x = 0.f;
    CGFloat y = 0.f;
    CGFloat draughtOriginX = CGRectGetMinX(self.playingFieldRect) + self.indentedDraught;
    CGFloat draughtOriginY = CGRectGetMinY(self.playingFieldRect) + self.indentedDraught;
    CGFloat widthDraught=  CGRectGetWidth(self.playingFieldRect) / 8 - 2 * self.indentedDraught;
    CGFloat heightDraught = CGRectGetHeight(self.playingFieldRect) / 8  - 2 * self.indentedDraught;
    UIColor *colorDraught = redDraught ? [UIColor redColor] : [UIColor yellowColor];
    
    NSInteger startRow = redDraught ? 1 : 6;
    NSInteger finishRow = redDraught ? 3 : 8;
    
    NSInteger startColumn = redDraught ? 2 : 1;
    
    for(int row = startRow;row <= finishRow;row++)
    {
        startColumn = row % 2 ? 2 : 1;
        for(int column = startColumn;column <= 8;column = column + 2)
        {
            x = draughtOriginX +(widthDraught  + 2 * self.indentedDraught) * (column - 1);
            y = draughtOriginY + (heightDraught + 2 * self.indentedDraught) * (row - 1);
            
            CGRect r = CGRectMake(x, y, widthDraught, heightDraught);
            Draught *draughtView  = [[Draught alloc] initWithFrame:r withColor:colorDraught];
            [self addSubview:draughtView];
            redDraught ? [self.mArrayRedDraughts addObject:draughtView] : [self.mArrayYellowDraughts addObject:draughtView];
        }
    }
    
}

@end
