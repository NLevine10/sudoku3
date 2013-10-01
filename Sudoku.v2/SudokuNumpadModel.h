//
//  SudokuNumpadModel.h
//  Sudoku.v2
//
//  Created by SDA on 9/13/13.
//  Copyright (c) 2013 Sean Adler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SudokuNumpadModel : NSObject
@property (nonatomic, strong) NSArray *numpadNumbers;
@property (nonatomic, strong) NSString *selectedTile;
@property (nonatomic) BOOL tileIsSelected;
@end
