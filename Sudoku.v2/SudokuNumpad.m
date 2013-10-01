//
//  SudokuNumpad.m
//  Sudoku.v2
//
//  Created by SDA on 9/13/13.
//  Copyright (c) 2013 Sean Adler. All rights reserved.
//

#import "SudokuNumpad.h"
#import "SudokuTile.h"

@implementation SudokuNumpad

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)highlightTile:(NSString *)tileString
{
    for (SudokuTile *tile in self.subviews) {
        tile.backgroundColor = [UIColor whiteColor];
    }
    
    if (tileString == nil) return;
    
    for (SudokuTile *tile in self.subviews) {
        if ([tile.currentTitle isEqualToString:tileString]) {
            tile.backgroundColor = [UIColor yellowColor];
        }
    }
}


- (void)drawButtonsUsingArray:(NSArray *)array
{
    self.backgroundColor = [UIColor blackColor];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    int dimensionX = width * 0.09;
    int dimensionY = 6 + height * 0.1;
    
    for (int i = 0; i < array.count; i++) {
        
        int originX = width*0.1005 + i*dimensionX;
        int originY = dimensionY;
        
        int size = width * 0.08;
        CGRect buttonFrame = CGRectMake(originX, originY, size, size);
        
        SudokuTile *tile = [[SudokuTile alloc] initWithFrame:buttonFrame];
        tile.backgroundColor = [UIColor whiteColor];
        NSString *buttonTitle = array[i];
        
        tile.index = i;
        
        [tile setTitle:buttonTitle forState:UIControlStateNormal];
        [tile setTitle:buttonTitle forState:UIControlStateSelected];
        [tile setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [tile addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:tile];
    }
}


- (void)buttonPressed:(SudokuTile *)sender
{
    [self.delegate numpadTilePressedAtIndex:sender.index];
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
