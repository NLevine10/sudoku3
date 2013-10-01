//
//  Sudoku_v3Tests.h
//  Sudoku.v3Tests
//
//  Created by SDA on 9/24/13.
//  Copyright (c) 2013 Sean Adler. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "SudokuGrid.h"
#import "SudokuGridModel.h"
#import "SudokuNumpad.h"
#import "SudokuNumpadModel.h"
#import "SudokuTile.h"

@interface Sudoku_v3Tests : SenTestCase
{
    SudokuGrid *grid;
    SudokuGridModel *gridModel;
    SudokuNumpad *numpad;
    SudokuNumpadModel *numpadModel;
    SudokuTile *tile;
}

- (void)testGridModelCount;
- (void)testNumpadModelCount;
- (void)testGridModelGetter;
- (void)testGridModelSetter;
- (void)testTileIndexSetter;

@end

