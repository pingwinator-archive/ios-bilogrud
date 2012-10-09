//
//  BoardViewController.m
//  TetrisNew
//
//  Created by Natasha on 08.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "BoardViewController.h"
#import "BoardView.h"
#import "TetrisShape.h"
#import "Cell.h"
@interface BoardViewController ()
@property (retain, nonatomic) TetrisShape* nextShape;
@property (retain, nonatomic) TetrisShape* currentShape;
@property (retain, nonatomic) NSMutableSet* borderSet;
@property (retain, nonatomic) NSMutableSet* fallenShapeSet;
- (NSMutableSet*)cellsToPoints:(NSMutableSet*)cells;
@end

@implementation BoardViewController
@synthesize boardView;
@synthesize gameOver;
@synthesize nextShape;
@synthesize currentShape;
@synthesize boardCells;
@synthesize borderSet;
@synthesize fallenShapeSet;

- (void)setBoardCells:(NSMutableSet *)_boardCells
{
    [boardCells release];
    boardCells = [_boardCells retain];
  
    self.boardView.boardCellsForDrawing = _boardCells;
}

- (void)dealloc
{
    self.boardView = nil;
    self.fallenShapeSet = nil;
    self.borderSet = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame amountCellX:(NSInteger)cellX
{
    self = [super init];
    if(self) {
        
        self.boardView = [[BoardView alloc] initWithFrame:frame amountCellX:cellX];
        self.boardView.backgroundColor = [UIColor lightGrayColor];
        self.gameOver = NO;
        
        //shape
        self.startPoint = CGPointMake(5, 2);
        self.currentShape = [[TetrisShape alloc] initRandomShapeWithCenter:self.startPoint];
        
        self.fallenShapeSet = [[NSMutableSet alloc] init];
        
        self.borderSet = [[NSMutableSet alloc] init];
        for (NSInteger i = 0; i < self.boardView.amountCellX ; i++) {
            [borderSet addObject:PointToObj(CGPointMake(i, self.boardView.amountCellY))];
        }
        for (NSInteger j = 0; j < self.boardView.amountCellY; j++) {
            [borderSet addObject:PointToObj(CGPointMake(-1, j))];
            [borderSet addObject:PointToObj(CGPointMake(self.boardView.amountCellX, j))];
        }
        
        //
        [self updateBoard];
    //    [self.boardCells unionSet:self.currentShape.shapePoints];
    }
    return self;
}

- (void)updateBoard
{
    NSMutableSet* cellsCurrentShape = [[NSMutableSet alloc] initWithSet:[self pointsToCells:[self.currentShape getShapePoints]]];
    
    self.boardCells = [[NSMutableSet alloc] initWithSet:cellsCurrentShape];
    [self.boardCells unionSet:cellsCurrentShape];
    [self.boardCells unionSet:fallenShapeSet];
}

- (NSMutableSet*)pointsToCells:(NSMutableSet*)points
{
    NSMutableSet* cells = [[NSMutableSet alloc] init];
    for (NSValue* v in points) {
       [cells addObject: [Cell pointToCell:v withColor:self.currentShape.shapeColor ]];
    }
    return cells;
}

- (NSMutableSet*)cellsToPoints:(NSMutableSet*)cells
{
    NSMutableSet* points = [[NSMutableSet alloc] init];
    for (Cell* c in cells) {
        [points addObject: [Cell cellToPointObj:c]];
    }
    return points;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Move Shape
- (void)moveShape:(DirectionMove) directionMove
{
    NSMutableSet* tempSet = [NSMutableSet setWithSet:[self.currentShape getMovedShape:directionMove]];
    if([self validationMove:tempSet])
    {
        NSLog( @"valid to move");
        [self.currentShape deepMove:directionMove];
        [self updateBoard];
        //[self.boardView setNeedsDisplay];
    } else {
        if (directionMove == downDirectionMove && !self.gameOver) {
            NSInteger amountDeleted = 0;
            NSInteger minY = 0;
            NSInteger maxY = 0;
            [self.fallenShapeSet unionSet:[self pointsToCells:[self.currentShape getShapePoints]]];
            //check for game over
            for (Cell* c in self.boardCells) {
                if( c.point.y == 2) {
                    self.gameOver = YES;
                }
            }
            //check line where shape was add
            for (NSValue* v in [self.currentShape getShapePoints]) {
                if(PointFromObj(v).y > maxY) {
                    maxY = PointFromObj(v).y;
                }
                if(PointFromObj(v).y < minY) {
                    minY = PointFromObj(v).y;
                }
            }
            for (NSInteger i = maxY; i >= minY; i--) {
                NSInteger count = 0;
                for (Cell* c in self.fallenShapeSet) {
                    if(c.point.y == i + amountDeleted) {
                        count++;
                    }
                    if (count == self.boardView.amountCellX)
                    {
                        self.fallenShapeSet = [self deleteLine:self.fallenShapeSet line:i+amountDeleted];
                        amountDeleted++;
                    }
                }
            }
            self.currentShape = self.nextShape;
            self.nextShape = [[TetrisShape alloc] initRandomShapeWithCenter:self.startPoint];
        }
        
        NSLog( @"not valid to move");
    }
}

- (NSMutableSet*)deleteLine:(NSMutableSet*)boardPoints line:(NSInteger)numberLine
{
    NSMutableSet* tempSet = [NSMutableSet setWithSet:[self cellsToPoints:boardPoints]];
    for (NSInteger i = 0; i < [self.boardPoints count]; i++) {
      //  if(
    [tempSet isa//intersectsSet:<#(NSSet *)#>]
        
    }
    return tempSet;
                          /*
     HashSet<Point> test = new HashSet<Point>(cellToPoint(boardPoints));
     for(int i = 0; i < boardPoints.Count; i++)
     {
     if(test.Contains(new Point(i, numberLine)))
     {
     test.Remove(new Point(i, numberLine));
     }
     }
     HashSet<Cell> final = new HashSet<Cell>();
     foreach(Cell cell in boardPoints)
     {
     if(test.Contains(cell.cellPoint))
     {
     if(cell.cellPoint.Y < numberLine)
     {
     int y = cell.cellPoint.Y;
     y++;
     final.Add(new Cell(new Point(cell.cellPoint.X, y), cell.colorPoint));
     }
     else
     {
     final.Add(new Cell(new Point(cell.cellPoint.X, cell.cellPoint.Y), cell.colorPoint));
     }
     }
     }
     return final;
     */
}
- (BOOL)validationMove:(NSMutableSet*)validateSet
{
    return !([validateSet intersectsSet:self.borderSet] && [validateSet intersectsSet:self.fallenShapeSet]);
}
@end
