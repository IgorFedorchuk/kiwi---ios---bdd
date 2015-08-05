//
//  IFQuestionTableDelegate.m
//  use-bdd
//
//  Created by Igor on 08.01.13.
//  Copyright (c) 2013 IgorFedorchuk. All rights reserved.
//

#import "IFQuestionTableDelegate.h"
#import "IFQuestionCell.h"
#import "IFSpinerCell.h"
#import "IFQuestion.h"
#import "NSArray+UniqueArray.h"

@interface IFQuestionTableDelegate()

@property(nonatomic, weak) IBOutlet IFQuestionCell *questionCell;
@property(nonatomic, weak) IBOutlet IFSpinerCell *spinerCell;
@property(nonatomic, weak) id<QuestionTableDelegate> delegate;

@property(nonatomic, strong) NSMutableArray *questions;

@end


@implementation IFQuestionTableDelegate

-(instancetype)init
{
    if (self = [super init])
    {
        self.questions = [NSMutableArray array];
    }
    return self;
}

-(instancetype)initWithDelegate:(id<QuestionTableDelegate>)tableDelegate
{
    if (self = [self init])
    {
        self.delegate = tableDelegate;
    }
    return self;
}

-(void)addQuestions:(NSArray *)newQuestions
{
    [self.questions addObjectsFromArray:newQuestions];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date"
                                                  ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [self.questions sortedArrayUsingDescriptors:sortDescriptors];
    NSArray *uniqueArray = [sortedArray uniqueByBlock:^BOOL(id first, id second)
                            {
                                return [(IFQuestion*)first questionID] == [(IFQuestion*)second questionID];
                            }];
    
    self.questions = [NSMutableArray array];
    [self.questions addObjectsFromArray:uniqueArray];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self createCellForTable:tableView forRow:indexPath.row];
       
    if ([self isLastRow:indexPath.row andNotVisibleOnTable:tableView])
    {
        return cell;
    }
    
    if (indexPath.row < self.questions.count)
    {
        IFQuestionCell *questionCell = (IFQuestionCell *)cell;
        [questionCell configWithQuestion:[self.questions objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isLastRow:indexPath.row andNotVisibleOnTable:tableView])
    {
        [self.delegate needMoreQuestions];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isLastRow:indexPath.row andNotVisibleOnTable:tableView])
    {
        return 50;
    }
    
    return 120;
}

#pragma mark - Util
-(UITableViewCell *)createCellForTable:(UITableView *)tableView forRow:(NSInteger)row
{
    if ([self isLastRow:row andNotVisibleOnTable:tableView])
    {
        return [self createSpinerCellForTable:tableView];
    }

    return [self createQuestionCellForTable:tableView];
}

-(UITableViewCell *)createQuestionCellForTable:(UITableView *)tableView 
{
    static NSString *CellIdentifier = @"IFQuestionCell";
    IFQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        [Bundle loadNibNamed:@"IFQuestionCell" owner:self options:nil];
        cell = self.questionCell;
        self.questionCell = nil;
    }
    
    return cell;
}

-(UITableViewCell *)createSpinerCellForTable:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"IFSpinerCell";
    IFSpinerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        [Bundle loadNibNamed:@"IFSpinerCell" owner:self options:nil];
        cell = self.spinerCell;
        self.spinerCell = nil;
    }
    return cell;
}

-(BOOL)isLastRow:(NSInteger)row andNotVisibleOnTable:(UITableView *)table
{
    NSInteger fakeVisibleRowsOnTable = table.frame.size.height / table.rowHeight;
    return ((row == self.questions.count - 1) && (fakeVisibleRowsOnTable < row));
}

@end
