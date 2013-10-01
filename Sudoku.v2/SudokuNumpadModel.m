//
//  SudokuNumpadModel.m
//  Sudoku.v2
//
//  Created by SDA on 9/13/13.
//  Copyright (c) 2013 Sean Adler. All rights reserved.
//

#import "SudokuNumpadModel.h"

@implementation SudokuNumpadModel

- (id)init
{
    self = [super init];
    if (self) {
        self.numpadNumbers = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    }
    return self;
}

@end
