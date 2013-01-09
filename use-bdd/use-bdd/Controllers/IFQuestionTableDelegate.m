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

@interface IFQuestionTableDelegate()

@property(nonatomic, strong) NSMutableArray *questions;
@property(nonatomic, strong) IBOutlet IFQuestionCell *questionCell;
@property(nonatomic, strong) IBOutlet IFSpinerCell *spinerCell;

@end


@implementation IFQuestionTableDelegate

-(id)init
{
    if (self = [super init])
    {
        self.questions = [NSMutableArray array];
    }
    return self;
}

-(void)addQuestions:(NSArray *)newQuestions
{
    [self.questions addObjectsFromArray:newQuestions];
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
