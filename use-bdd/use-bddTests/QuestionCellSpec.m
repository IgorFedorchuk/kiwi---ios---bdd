#import "Kiwi.h"
#import "IFQuestionCell.h"
#import "NSObject+Properties.h"
#import "IFQuestion.h"
#import "IFQuestionTableDelegate.h"
#import "IFPerson.h"

SPEC_BEGIN(QuestionCellSpec)

describe(@"QuestionCellSpec", ^
{
    __block IFQuestionTableDelegate *tableDelegate = nil;
    
    beforeEach(^
    {
        
        tableDelegate = [IFQuestionTableDelegate new];
        
        IFQuestion *first = [IFQuestion new];
        first.title = @"No";
        first.score = 1;
        first.asker = [[IFPerson alloc] initWithName:@"Igor" avatarLocation:@"Igor1"];        
        [tableDelegate addQuestions:@[first]];        
    });
    
    afterEach(^
    {
        tableDelegate = nil;
    });

    it(@"spiner should be visible during avatar loading", ^
    {
        IFQuestionCell *cell = (IFQuestionCell *)[tableDelegate tableView:[UITableView new] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

        UIImageView *askerAvatar = (UIImageView *)[cell objectForPropertyName:@"askerAvatar"];
        [askerAvatar.image shouldBeNil];

        UIActivityIndicatorView *spiner = (UIActivityIndicatorView *)[cell objectForPropertyName:@"spiner"];
        [spiner shouldNotBeNil];
        [[theValue(spiner.hidden) should] equal:theValue(NO)];
        [[theValue(spiner.isAnimating) should] equal:theValue(YES)];
    });
    
    it(@"spiner should be hidden when avatar is loaded", ^
    {
           IFQuestionCell *cell = (IFQuestionCell *)[tableDelegate tableView:[UITableView new] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
           
           UIImageView *askerAvatar = (UIImageView *)[cell objectForPropertyName:@"askerAvatar"];
           askerAvatar.image = [UIImage new];
           
           UIActivityIndicatorView *spiner = (UIActivityIndicatorView *)[cell objectForPropertyName:@"spiner"];
           [spiner shouldNotBeNil];
           [[theValue(spiner.hidden) should] equal:theValue(YES)];
    });
});

SPEC_END

