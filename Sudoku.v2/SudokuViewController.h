//
//  SudokuViewController.h
//  Sudoku.v2
//
//  Created by SDA on 9/13/13.
//  Copyright (c) 2013 Sean Adler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SudokuGrid.h"
#import "SudokuNumpad.h"

@class SudokuGrid;
@class SudokuNumpad;

@interface SudokuViewController : UIViewController <GridTileDelegate, NumpadTileDelegate>
@property (nonatomic, strong) SudokuGrid *grid;
@property (nonatomic, strong) SudokuNumpad *numpad;


@end
