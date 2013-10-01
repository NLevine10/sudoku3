//
//  SudokuGridModel.m
//  Sudoku.v2
//
//  Created by SDA on 9/13/13.
//  Copyright (c) 2013 Sean Adler. All rights reserved.
//

#import "SudokuGridModel.h"

@implementation SudokuGridModel

- (id)init {

    self = [super init];
    
    if (self) {
        
        self.selectedTile = @"";
        self.selectedTileIndex = -1;
        
        self.tileIsSelected = NO;
    
    }
    return self;
}
//Random board generator from input text file. Uses multiples of 81 + the offset because puzzles are separated by a '.' character.
- (NSMutableArray *)randBoard:(NSString *) boards
{
    int rand = arc4random() % 30000;
    NSMutableArray *playingBoard = [[NSMutableArray alloc] init];
    int j = rand*81 + rand;
    for (int i = 0; i < 81; i++) {
        if ([[boards substringWithRange:NSMakeRange(j, 1)] isEqualToString: @"."]) {
            [playingBoard addObject: @" "];
        }
        else {
            [playingBoard addObject:[boards substringWithRange:NSMakeRange(j, 1)]];
        }
        j++;
    }
    return playingBoard;
}

//Initialize the numbers on the board as well as the editable array
-(void)setBoard:(NSMutableArray *) board
{
    self.gridNumbers = board;
    
    // Store whether each cell is editable (Contains blank at beginning of game.)
    self.gridNumbersEditable = [NSMutableArray arrayWithCapacity:self.gridNumbers.count];
    
    for (int i = 0; i < self.gridNumbers.count; i++) {
        BOOL indexIsEditable = [self.gridNumbers[i] isEqualToString:@" "];
        [self.gridNumbersEditable addObject:[NSNumber numberWithBool:indexIsEditable]];
    }
    
}

- (BOOL)validTile:(NSString *)tile forIndex:(int)index
{
    // Check column for same tile
    NSMutableArray *columnArray = [[NSMutableArray alloc] init];
    for (int i=0; i<9; i++) {
        [columnArray addObject:self.gridNumbers[(index%9) + (i*9)]];
    }
    BOOL columnValid = ![columnArray containsObject:tile];
    
    // Check row for same tile
    NSMutableArray *rowArray = [[NSMutableArray alloc] init];
    int rowIndex = index - (index % 9);
    int rowStop = rowIndex + 9;
    for (; rowIndex<rowStop; rowIndex++) {
        [rowArray addObject:self.gridNumbers[rowIndex]];
    }
    BOOL rowValid = ![rowArray containsObject:tile];
    
    // Check 3x3 box for same tile
    NSMutableArray *boxArray = [[NSMutableArray alloc] init];
    int row = index / 9;
    int col = index % 9;
    // Move row and col to the top-left corner of their 3x3 box.
    row = row / 3;
    row = row * 3;
    col = col / 3;
    col = col * 3;
    NSLog(@"row: %d, col: %d", row, col);
    
    int boxIndex = (row*9) + col - 7;
    
    for (int i = 0; i < 9; i++) {
        if (i % 3 == 0) {
            // Move to new row of the same box.
            boxIndex += 6;
        }
        ++boxIndex;
        
        NSLog(@"boxIndex: %d", boxIndex);
        
        [boxArray addObject:self.gridNumbers[boxIndex]];
    }
    NSLog(@"boxArray: %@", boxArray);
    
    
    //    int boxIndex = index - (index % 9);
    
    // TODO fix all this
    BOOL boxValid = ![boxArray containsObject:tile];
    
    NSLog(@"column valid: %c, row valid: %c, box valid: %c", columnValid, rowValid, boxValid);
    return columnValid && rowValid && boxValid;
}




@end
