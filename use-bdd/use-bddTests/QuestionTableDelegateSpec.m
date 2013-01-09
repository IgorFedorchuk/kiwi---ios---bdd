#import "Kiwi.h"
#import "IFQuestionTableDelegate.h"
#import "IFQuestion.h"
#import "IFPerson.h"
#import "IFQuestionCell.h"
#import "IFPerson.h"
#import "NSObject+Properties.h"
#import "IFViewController.h"
#import "IFSpinerCell.h"


SPEC_BEGIN(QuestionTableDelegateSpec)

describe(@"QuestionTableDelegateSpec", ^
{
    context(@"", ^
    {
        __block IFQuestionTableDelegate *tableDelegate = nil;
        __block UITableView *tableView = nil;
        
        beforeEach(^
        {
            tableDelegate = [IFQuestionTableDelegate new];
            IFQuestion *first = [IFQuestion new];
            IFQuestion *second = [IFQuestion new];
            first.title = @"No";
            first.score = 1;
            first.asker = [[IFPerson alloc] initWithName:@"Igor" avatarLocation:@"Igor1"];
            second.title = @"Yes";
            second.score = 2;
            second.asker = [[IFPerson alloc] initWithName:@"Bill" avatarLocation:@"Bill1"];
            
            NSArray *quistions = [NSArray arrayWithObjects:first, second, nil];
            [tableDelegate addQuestions:quistions];
            
            IFViewController *viewController = [[IFViewController alloc] initWithNibName:@"IFViewController_iPhone" bundle:nil];
            
            UIView *aView = viewController.view; // lazy load
            aView = nil;
            tableView = (UITableView *)[viewController valueForPropertyName:@"tableView"];
        });

        afterEach(^
        {
            tableDelegate = nil;
            tableView = nil;
        });
        
        it(@"should conform UITableViewDataSource, UITableViewDelegate protocols", ^
        {
            [[tableDelegate should] conformToProtocol:@protocol(UITableViewDataSource)];
            [[tableDelegate should] conformToProtocol:@protocol(UITableViewDelegate)];
        });       
        
        it(@"no questions no cell", ^
        {
            IFQuestionTableDelegate *questionTableDelegate = [IFQuestionTableDelegate new];
            
            NSInteger cellNumber = [questionTableDelegate tableView:[UITableView mock] numberOfRowsInSection:0];
            [[theValue(cellNumber) should] equal:theValue(0)];

            [questionTableDelegate addQuestions:[NSArray array]];
            cellNumber = [questionTableDelegate tableView:[UITableView mock] numberOfRowsInSection:0];
            [[theValue(cellNumber) should] equal:theValue(0)];            
        });
        
        it(@"2 questions 2 cells", ^
        {            
            NSInteger cellNumber = [tableDelegate tableView:[UITableView mock] numberOfRowsInSection:0];
            [[theValue(cellNumber) should] equal:theValue(2)];
        });
        
        it(@"add 2 questions , need to get 4 cells", ^
        {
            IFQuestion *first = [IFQuestion new];
            IFQuestion *second = [IFQuestion new];
            first.title = second.title = @"Yes";
            NSArray *quistions = [NSArray arrayWithObjects:first, second, nil];
            [tableDelegate addQuestions:quistions];
            
            NSInteger cellNumber = [tableDelegate tableView:[UITableView mock] numberOfRowsInSection:0];
            [[theValue(cellNumber) should] equal:theValue(4)];
        });
        
        it(@"texts of cells labels should be appropriated to properties of question ", ^
        {
            IFQuestionCell *cell1 = (IFQuestionCell *)[tableDelegate tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            UILabel *titleLabel = (UILabel *)[cell1 valueForPropertyName:@"titleLabel"];
            UILabel *scoreLabel = (UILabel *)[cell1 valueForPropertyName:@"scoreLabel"];
            UILabel *askerNameLabel = (UILabel *)[cell1 valueForPropertyName:@"askerNameLabel"];

            [[titleLabel.text should] equal:@"No"];
            [[scoreLabel.text should] equal:@"1"];
            [[askerNameLabel.text should] equal:@"Igor"];
            
            IFQuestionCell *cell2 = (IFQuestionCell *)[tableDelegate tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            titleLabel = (UILabel *)[cell2 valueForPropertyName:@"titleLabel"];
            scoreLabel = (UILabel *)[cell2 valueForPropertyName:@"scoreLabel"];
            askerNameLabel = (UILabel *)[cell2 valueForPropertyName:@"askerNameLabel"];
            
            [[titleLabel.text should] equal:@"Yes"];
            [[scoreLabel.text should] equal:@"2"];
            [[askerNameLabel.text should] equal:@"Bill"];
        });
        
        it(@"if row of indexPath greater than  number of objects in questions array should return empty cell", ^
        {
            IFQuestionCell *cell1 = (IFQuestionCell *)[tableDelegate tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            UILabel *titleLabel = (UILabel *)[cell1 valueForPropertyName:@"titleLabel"];
            UILabel *scoreLabel = (UILabel *)[cell1 valueForPropertyName:@"scoreLabel"];
            UILabel *askerNameLabel = (UILabel *)[cell1 valueForPropertyName:@"askerNameLabel"];
            
            [[titleLabel.text should] equal:@"There was a problem."];
            [[scoreLabel.text should] equal:@""];
            [[askerNameLabel.text should] equal:@""];
        });
        
        it(@"spiner cell should be last cell, if last cell is not visible on table", ^
        {
            IFQuestion *first = [IFQuestion new];
            IFQuestion *second = [IFQuestion new];
            first.title = second.title = @"Yes";
            NSArray *quistions = [NSArray arrayWithObjects:first, second, nil];
            [tableDelegate addQuestions:quistions];
            [tableDelegate addQuestions:quistions];
            [tableDelegate addQuestions:quistions];
            [tableDelegate addQuestions:quistions];
    
            IFSpinerCell *cell = (IFSpinerCell *)[tableDelegate tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0]];
            
            NSString *cellClassName = NSStringFromClass ([cell class]);
            [[cellClassName should] equal:NSStringFromClass ([IFSpinerCell class])];
        });
        
        it(@"", ^
        {
            
        });
    });
});



SPEC_END
