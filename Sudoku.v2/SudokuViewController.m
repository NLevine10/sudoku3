//
//  SDAViewController.m
//  Sudoku.v1
//
//  Created by SDA on 9/6/13.
//  Copyright (c) 2013 Sean Adler. All rights reserved.
//

#import "SudokuViewController.h"
#import "SudokuGridModel.h"
#import "SudokuNumpadModel.h"
//#import "SudokuGrid.h"
#import "SudokuNumpad.h"
#import "SudokuTile.h"


#define xInset 0
#define yInset 10

typedef NS_ENUM(NSUInteger, LastTilePressedType) {
    GRID,
    NUM_PAD
};


@interface SudokuViewController ()

@property (nonatomic, strong) SudokuGridModel *gridModel;
@property (nonatomic, strong) SudokuNumpadModel *numpadModel;
@property (nonatomic) LastTilePressedType lastTilePressed;
@property (nonatomic, strong) NSString *highlightTileStr;
@property (nonatomic, strong) UIButton *resetButton;
//@property (nonatomic, strong) NSMutableArray* board;
@property (nonatomic, strong) NSMutableArray* board;
@property (nonatomic, strong) NSString* readString;
@end

@implementation SudokuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Initial load in of the sudoku boards from raw text file to NSString
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"sudokus0" ofType: @"txt"];
    NSError* error;
    
    self.readString =[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    //NSLog(@"Read value: %@", readString);
    
    
    
    // Instantiate models
    self.gridModel = [[SudokuGridModel alloc] init];
    self.numpadModel = [[SudokuNumpadModel alloc] init];
   
    // Set other properties
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create frame for grid.
    int originX = 57.6; //self.view.bounds.size.width * .10;
    int originY = 120.1; //self.view.bounds.size.height * .10;
    int size = 652.8; //MIN(self.view.bounds.size.width, self.view.bounds.size.height) * .6;
    CGRect gridFrame = CGRectMake(originX, originY, size, size);
    //NSLog(@"Width is: %f.\n", self.view.bounds.size.width);
    //NSLog(@"Height is: %f.\n", self.view.bounds.size.height);
    
    // Create grid.
    self.grid = [[SudokuGrid alloc] initWithFrame:gridFrame];
    
    
    // Tell grid view to draw itself using a random board
    self.board = [self.gridModel randBoard:self.readString];
    [self.gridModel setBoard:self.board];
    [self.grid drawButtonsUsingArray:self.board];
    
    
    // Set up delegation so touch events propagate back up to this controller
    self.grid.delegate = self;
    [self.view addSubview:self.grid];
    
    
    // Create numpad.
    CGRect numpadFrame = CGRectMake(originX, originY+size+30, size, 81);
    self.numpad = [[SudokuNumpad alloc] initWithFrame:numpadFrame];
    [self.numpad drawButtonsUsingArray:self.numpadModel.numpadNumbers];
    
    
    // Numpad also needs delegation for touch events.
    self.numpad.delegate = self;
    [self.view addSubview:self.numpad];
    
    // Add New Game button.
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    newButton.frame = CGRectMake(57.6, size+231.1, 100, 50); // position in the parent view and set the size of the button
    newButton.backgroundColor = [UIColor blackColor];
    [newButton setTitle:@"New Game" forState:UIControlStateNormal];
    [self.view addSubview:newButton];
    [newButton addTarget:self action:@selector(newPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Test button for full grid (puzzle complete)
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    testButton.frame = CGRectMake(157.6, size+231.1, 100, 50); // position in the parent view and set the size of the button
    testButton.backgroundColor = [UIColor blackColor];
    [testButton setTitle:@"TEST" forState:UIControlStateNormal];
    [self.view addSubview:testButton];
    [testButton addTarget:self action:@selector(testPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //Reset button for current puzzle
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    resetButton.frame = CGRectMake(610.4, size+231.1, 100, 50); // position in the parent view and set the size of the button
    resetButton.backgroundColor = [UIColor blackColor];
    [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    [self.view addSubview:resetButton];
    [resetButton addTarget:self action:@selector(resetPressed:) forControlEvents:UIControlEventTouchUpInside];

    
    //self.resetButton.titleLabel.text = @"RESET";
    //[self.resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     
}


// updateUI:  handles all UI logic for views based on model data.
- (void)updateUI
{
    for (int i = 0; i < self.gridModel.gridNumbers.count; i++) {
        [self.grid setTileAtIndex:i
                          toValue:self.gridModel.gridNumbers[i]
                         editable:[self.gridModel.gridNumbersEditable[i] boolValue]];
    }
// test for full grid (complete puzzle)
    [self.grid highlightTiles:self.highlightTileStr];
    int n = 0;
    while (n < self.gridModel.gridNumbers.count && ![self.gridModel.gridNumbers[n] isEqualToString:@" "]) {
        n++;
        if (n == self.gridModel.gridNumbers.count) {
// if complete pop up an alert box
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You completed the puzzle"
                    delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"New Game", nil];
            [alert show];
        }
    }
}

//Test button handler - fills grid and pops up alert
- (void)testPressed:(UIButton *)sender {
    NSMutableArray *testGrid;
    testGrid = [NSMutableArray arrayWithObjects:
                        @"4", @"5", @"7", @"3", @"8", @"1", @"2", @"6", @"9",
                        @"1", @"6", @"2", @"5", @"4", @"9", @"8", @"7", @"3",
                        @"9", @"3", @"8", @"2", @"7", @"6", @"4", @"5", @"1",
                        @"3", @"7", @"4", @"8", @"6", @"2", @"1", @"9", @"5",
                        @"8", @"2", @"5", @"9", @"1", @"7", @"3", @"4", @"6",
                        @"6", @"1", @"9", @"4", @"3", @"5", @"7", @"2", @"8",
                        @"2", @"4", @"1", @"6", @"5", @"8", @"9", @"3", @"7",
                        @"5", @"8", @"3", @"7", @"9", @"4", @"6", @"1", @"2",
                        @"7", @"9", @"6", @"1", @"2", @"3", @"5", @"8", @"4", nil];
    [self.gridModel setBoard:testGrid];
    [self updateUI];
}

//New Game button handler, loads new grid
- (void)newPressed:(UIButton *)sender {
    self.board = [self.gridModel randBoard:self.readString];
    [self.gridModel setBoard:self.board];
    //[self.grid drawButtonsUsingArray:self.board];
    [self updateUI];
}

//Resets board back to original unedited state
- (void)resetPressed:(UIButton *)sender {
    
    for (int i = 0; i < self.gridModel.gridNumbersEditable.count; i++) {
        NSNumber *val = self.gridModel.gridNumbersEditable[i];
        BOOL success = [val boolValue];
        if (success) {
            self.gridModel.gridNumbers[i] = @" ";
        }
    [self updateUI];
    }
}

// gridTilePressedAtIndex:  sets model properties and calls updateUI:
- (void)gridTilePressedAtIndex:(NSUInteger)tileIndex
{
    NSString *newTileString = self.gridModel.gridNumbers[tileIndex];
    
    [self.numpad highlightTile:nil];
    
    if ([self.gridModel.gridNumbersEditable[tileIndex] boolValue]
        && (self.lastTilePressed == NUM_PAD)) {
        // Place a tile
        if ([self.gridModel validTile:self.numpadModel.selectedTile forIndex:tileIndex]) {
            
            self.gridModel.gridNumbers[tileIndex] = self.numpadModel.selectedTile;
            self.gridModel.selectedTile = newTileString;
            self.gridModel.selectedTileIndex = tileIndex;
            self.highlightTileStr = nil;
            
        } else {
            NSLog(@"Not a legal move.");
            [self.grid flashRedAtIndex:tileIndex];
            // invalid tile placement
            // TODO -- flash red
            return;
        }
        
    } else {
        
        self.highlightTileStr = newTileString;
        self.gridModel.selectedTileIndex = tileIndex;
    }
    
    self.lastTilePressed = GRID;
    [self updateUI];
    
    NSLog(@"Grid tile %@ pressed at index %d.\n",
          self.gridModel.gridNumbers[self.gridModel.selectedTileIndex], tileIndex);
}


- (void)numpadTilePressedAtIndex:(NSUInteger)tileIndex
{
    NSLog(@"Numpad tile %@ pressed at index %d.\n",
          self.numpadModel.numpadNumbers[tileIndex], tileIndex);
    
    self.highlightTileStr = self.numpadModel.numpadNumbers[tileIndex];
    self.numpadModel.tileIsSelected = YES;
    self.numpadModel.selectedTile = [self.numpadModel.numpadNumbers objectAtIndex:tileIndex];
    
    [self.numpad highlightTile:self.numpadModel.selectedTile];
    self.lastTilePressed = NUM_PAD;
    [self updateUI];
}
//Alert box button handler - button 1 is new game
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
		if (buttonIndex == 1){
            self.board = [self.gridModel randBoard:self.readString];
            [self.gridModel setBoard:self.board];
            [self updateUI];
		}
	}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
