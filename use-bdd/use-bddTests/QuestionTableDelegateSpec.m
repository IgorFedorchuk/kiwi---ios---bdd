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
        __block IFViewController *viewController = nil;

        beforeEach(^
        {
            viewController = [[IFViewController alloc] initWithNibName:@"IFViewController_iPhone" bundle:nil];
            
            UIView *aView = viewController.view; // lazy load
            aView = nil;
            tableView = (UITableView *)[viewController objectForPropertyName:@"tableView"];
            
            tableDelegate = [[IFQuestionTableDelegate alloc] initWithDelegate:viewController];
            
            IFQuestion *first = [IFQuestion new];
            first.title = @"No";
            first.score = 1;
            first.questionID = 1000;
            first.asker = [[IFPerson alloc] initWithName:@"Igor" avatarLocation:@"Igor1"];
            first.date = [NSDate dateWithTimeIntervalSince1970: 1273660706];

            IFQuestion *second = [IFQuestion new];
            second.title = @"Yes";
            second.score = 2;
            second.asker = [[IFPerson alloc] initWithName:@"Bill" avatarLocation:@"Bill1"];
            second.date = [NSDate dateWithTimeIntervalSince1970: 1273680706];
            second.questionID = 1001;
            
            NSArray *quistions = @[first, second];
            [tableDelegate addQuestions:quistions];
            
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
            first.questionID = 1;
            second.questionID = 2;
            
            [tableDelegate addQuestions:@[first, second]];
            
            NSInteger cellNumber = [tableDelegate tableView:[UITableView mock] numberOfRowsInSection:0];
            [[theValue(cellNumber) should] equal:theValue(4)];
        });
        
        it(@"texts of cells labels should be appropriated to properties of question ", ^
        {
            IFQuestionCell *cell1 = (IFQuestionCell *)[tableDelegate tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            UILabel *titleLabel = (UILabel *)[cell1 objectForPropertyName:@"titleLabel"];
            UILabel *scoreLabel = (UILabel *)[cell1 objectForPropertyName:@"scoreLabel"];
            UILabel *askerNameLabel = (UILabel *)[cell1 objectForPropertyName:@"askerNameLabel"];

            [[titleLabel.text should] equal:@"Yes"];
            [[scoreLabel.text should] equal:@"2"];
            [[askerNameLabel.text should] equal:@"Bill"];
            
            IFQuestionCell *cell2 = (IFQuestionCell *)[tableDelegate tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            titleLabel = (UILabel *)[cell2 objectForPropertyName:@"titleLabel"];
            scoreLabel = (UILabel *)[cell2 objectForPropertyName:@"scoreLabel"];
            askerNameLabel = (UILabel *)[cell2 objectForPropertyName:@"askerNameLabel"];
            
            [[titleLabel.text should] equal:@"No"];
            [[scoreLabel.text should] equal:@"1"];
            [[askerNameLabel.text should] equal:@"Igor"];
        });
        
        it(@"if row of indexPath greater than  number of objects in questions array should return empty cell", ^
        {
            IFQuestionCell *cell1 = (IFQuestionCell *)[tableDelegate tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            UILabel *titleLabel = (UILabel *)[cell1 objectForPropertyName:@"titleLabel"];
            UILabel *scoreLabel = (UILabel *)[cell1 objectForPropertyName:@"scoreLabel"];
            UILabel *askerNameLabel = (UILabel *)[cell1 objectForPropertyName:@"askerNameLabel"];
            
            [[titleLabel.text should] equal:@"There was a problem."];
            [[scoreLabel.text should] equal:@""];
            [[askerNameLabel.text should] equal:@""];
        });
        
        it(@"spiner cell should be last cell, if last cell is not visible on table", ^
        {
            IFQuestion *q1 = [IFQuestion new];
            IFQuestion *q2 = [IFQuestion new];
            IFQuestion *q3 = [IFQuestion new];
            IFQuestion *q4 = [IFQuestion new];
            IFQuestion *q5 = [IFQuestion new];
            IFQuestion *q6 = [IFQuestion new];
            IFQuestion *q7 = [IFQuestion new];
            IFQuestion *q8 = [IFQuestion new];
            
            q1.questionID = 1;
            q2.questionID = 2;
            q3.questionID = 3;
            q4.questionID = 4;
            q5.questionID = 5;
            q6.questionID = 6;
            q7.questionID = 7;
            q8.questionID = 8;
            
            [tableDelegate addQuestions:@[q1, q2, q3, q4, q5, q6, q7, q8]];
    
            IFSpinerCell *cell = (IFSpinerCell *)[tableDelegate tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0]];
            
            NSString *cellClassName = NSStringFromClass ([cell class]);
            [[cellClassName should] equal:NSStringFromClass ([IFSpinerCell class])];
        });
        
        it(@"Array of questions should be sorted", ^
        {
            IFQuestion *third = [IFQuestion new];
            third.date = [NSDate dateWithTimeIntervalSince1970: 1273690706];            
            NSArray *quistions = [NSArray arrayWithObject:third];
            [tableDelegate addQuestions:quistions];
            
            NSMutableArray *newArray = (NSMutableArray *)[tableDelegate objectForPropertyName:@"questions"];
            
            IFQuestion *question1 = [newArray objectAtIndex:0];
            [[theValue([question1.date timeIntervalSince1970]) should] equal:theValue(1273690706)];

            IFQuestion *question2 = [newArray objectAtIndex:1];
            [[theValue([question2.date timeIntervalSince1970]) should] equal:theValue(1273680706)];

            IFQuestion *question3 = [newArray objectAtIndex:2];
            [[theValue([question3.date timeIntervalSince1970]) should] equal:theValue(1273660706)];
        });
        
        it(@"when last cell will be displayed should call needMoreQuestions", ^
        {
            IFQuestion *q1 = [IFQuestion new];
            IFQuestion *q2 = [IFQuestion new];
            IFQuestion *q3 = [IFQuestion new];
            IFQuestion *q4 = [IFQuestion new];
            IFQuestion *q5 = [IFQuestion new];
            IFQuestion *q6 = [IFQuestion new];
            IFQuestion *q7 = [IFQuestion new];
            IFQuestion *q8 = [IFQuestion new];
            
            q1.questionID = 1;
            q2.questionID = 2;            
            q3.questionID = 3;
            q4.questionID = 4;
            q5.questionID = 5;
            q6.questionID = 6;            
            q7.questionID = 7;
            q8.questionID = 8;
            
            [tableDelegate addQuestions:@[q1, q2, q3, q4, q5, q6, q7, q8]];
            
            [[viewController should] receive:@selector(needMoreQuestions)];

            NSIndexPath *path = [NSIndexPath indexPathForRow:9 inSection:0];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
            [tableDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:path];
            
            [[viewController shouldNot] receive:@selector(needMoreQuestions)];

            path = [NSIndexPath indexPathForRow:8 inSection:0];
            cell = [tableView cellForRowAtIndexPath:path];
            [tableDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:path];
        });
        
        it(@"Array should be without the same questions", ^
        {
            IFQuestion *q1 = [IFQuestion new];
            q1.questionID = 1;
            
            IFQuestion *q2 = [IFQuestion new];
            q2.questionID = 1;
            
            IFQuestion *q3 = [IFQuestion new];
            q3.questionID = 1;
            
            IFQuestion *q4 = [IFQuestion new];
            q4.questionID = 2;
            
            NSArray *quistions = @[q1, q2, q3, q4];
            [tableDelegate addQuestions:quistions];
               
            NSMutableArray *newArray = (NSMutableArray *)[tableDelegate objectForPropertyName:@"questions"];
            [[newArray should] haveCountOf:4];
        });
    });
});



SPEC_END
