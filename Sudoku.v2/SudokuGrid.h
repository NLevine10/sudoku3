//
//  SudokuGrid.h
//  Sudoku.v2
//
//  Created by SDA on 9/13/13.
//  Copyright (c) 2013 Sean Adler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GridTileDelegate
- (void)gridTilePressedAtIndex:(NSUInteger)tileIndex;
@end


@interface SudokuGrid : UIView

@property (nonatomic, strong) id <GridTileDelegate> delegate;
- (void)setTileAtIndex:(int)index toValue:(NSString *)value editable:(BOOL)isEditable;
- (void)drawButtonsUsingArray:(NSArray *)array;
- (void)highlightTiles:(NSString *)tileString;
- (void)buttonPressed:(id)sender;
- (void)flashRedAtIndex:(NSUInteger)index;
@end
