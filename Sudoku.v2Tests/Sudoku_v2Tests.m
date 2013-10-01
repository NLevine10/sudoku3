//
//  Sudoku_v3Tests.m
//  Sudoku.v3
//
//  Created by SDA on 9/24/13.
//  Copyright (c) 2013 Sean Adler. All rights reserved.
//

#import "Sudoku_v3Tests.h"

@implementation Sudoku_v3Tests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    grid = [[SudokuGrid alloc] init];
    gridModel = [[SudokuGridModel alloc] init];
    numpad = [[SudokuNumpad alloc] init];
    numpadModel = [[SudokuNumpadModel alloc] init];
    tile = [[SudokuTile alloc] init];
    
    STAssertNotNil(grid, @"Grid is nil");
    STAssertNotNil(gridModel, @"gridModel is nil");
    STAssertNotNil(numpad, @"numpad is nil");
    STAssertNotNil(numpadModel, @"numpadModel is nil");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testGridModelCount
{
    STAssertEqualObjects([NSNumber numberWithInteger:gridModel.gridNumbers.count], @81, @"gridModelCount is not 81");
}

- (void)testNumpadModelCount
{
    STAssertEqualObjects([NSNumber numberWithInteger:numpadModel.numpadNumbers.count], @9, @"numpadModelCount is not 9");
}

- (void)testGridModelGetter
{
    STAssertThrows([gridModel.gridNumbers objectAtIndex:-1], @"gridModel.gridNumbers negative index access");
    STAssertThrows([gridModel.gridNumbers objectAtIndex:NSUIntegerMax], @"gridModel.gridNumbers index too high");
}

- (void)testGridModelSetter
{
    STAssertThrows(gridModel.gridNumbers[-1] = @"0",
                   @"gridModel.gridNumbers negative index setter");
    STAssertThrows(gridModel.gridNumbers[NSUIntegerMax] = @"0",
                   @"gridModel.gridNumbers index too high setter");
}

- (void)testTileIndexSetter
{
    STAssertThrows([tile setIndex:-1], @"assigning negative index to tile");
}



@end
