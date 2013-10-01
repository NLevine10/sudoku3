//
//  SudokuGrid.m
//  tutorial2
//
//  Created by SDA on 9/3/13.
//  Copyright (c) 2013 Sean Adler. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SudokuGrid.h"
#import "SudokuTile.h"

#define xInset 0
#define yInset 0
#define NUM_SUBGRIDS 9


@implementation SudokuGrid

- (void)drawButtonsUsingArray:(NSArray *)array
{
    // Load hard-coded data from class method
    //    NSArray *dummyData = [SudokuGrid dummyData];
    
    self.backgroundColor = [UIColor blackColor];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    int dimensionX = width * 0.1;
    int dimensionY = height * 0.1;
    int n = 0;
    
    for (int i = 0; i < 9; i++) {
        
        for (int j = 0; j < 9; j++) {
            
            int originX = i*dimensionX;
            int originY = j*dimensionY;
            
            // Create spacing between tiles for 3x3 subgrids
            if (i < 3) originX = originX + width*0.03;
            else if (i < 6) originX = originX + width*0.06;
            else originX = originX + width*0.09;
            
            if (j < 3) originY = originY + height*0.03;
            else if (j < 6) originY = originY + height*0.06;
            else originY = originY + height*0.09;
            
            int size = width * 0.08;
            CGRect buttonFrame = CGRectMake(originX, originY, size, size);
            
            SudokuTile *tile = [[SudokuTile alloc] initWithFrame:buttonFrame];
            tile.backgroundColor = [UIColor whiteColor];
            NSString *buttonTitle = array[i + j*9];
            
            tile.index = i + j*9;
            
            [tile setTitle:buttonTitle forState:UIControlStateNormal];
            [tile setTitle:buttonTitle forState:UIControlStateSelected];
            [tile setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [tile addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [tile addTarget:self action:@selector(buttonTouchDownRepeat:event:) forControlEvents:UIControlEventTouchDownRepeat];
            [self addSubview:tile];
            n++;
        }
    }
}


- (void)flashRedAtIndex:(NSUInteger)index
{
    for (SudokuTile *tile in self.subviews) {
        if (tile.index == index) {
            tile.backgroundColor = [UIColor redColor];
            [UIView animateWithDuration:0.75
                             animations:^{
                                 tile.backgroundColor = [UIColor whiteColor];
                             }];
        }
    }
}


- (void)highlightTiles:(NSString *)tileString
{
    // Clear all highlighting first
    for (SudokuTile *tile in self.subviews) {
        tile.backgroundColor = [UIColor whiteColor];
    }
    
    
    if (tileString && ![tileString isEqualToString:@" "]) {
        for (SudokuTile *tile in self.subviews) {
            if ([tile.currentTitle isEqualToString:tileString]) {
                tile.backgroundColor = [UIColor yellowColor];
            }
        }
    }
}


- (void)setTileAtIndex:(int)index toValue:(NSString *)value editable:(BOOL)isEditable
{
    for (SudokuTile *tile in self.subviews) {
        if (tile.index == index) {
            [tile setTitle:value forState:UIControlStateNormal];
            [tile setTitle:value forState:UIControlStateSelected];
            if (isEditable) [tile setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            else [tile setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)buttonPressed:(SudokuTile *)sender
{
    [self.delegate gridTilePressedAtIndex:sender.index];
}

- (void) buttonTouchDownRepeat:(SudokuTile *)sender event:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if(touch.tapCount == 2) //&& [self.gridModel.gridNumbersEditable[sender.index] boolValue])
    {
        [self setTileAtIndex:sender.index
                          toValue:@" "
                         editable: 1];
    }
    else
    {
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
