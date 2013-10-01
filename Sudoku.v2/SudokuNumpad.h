//
//  SudokuNumpad.h
//  Sudoku.v2
//
//  Created by SDA on 9/13/13.
//  Copyright (c) 2013 Sean Adler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NumpadTileDelegate
- (void)numpadTilePressedAtIndex:(NSUInteger)tileIndex;
@end

@interface SudokuNumpad : UIView
- (void)drawButtonsUsingArray:(NSArray *)array;
- (void)highlightTile:(NSString *)tileString;
@property (nonatomic, strong) id <NumpadTileDelegate> delegate;
@end
