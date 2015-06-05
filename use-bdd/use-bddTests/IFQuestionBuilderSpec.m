#import "Kiwi.h"
#import "IFQuestionBuilder.h"
#import "IFQuestion.h"
#import "IFPerson.h"

//JSON example
static NSString *questionJSON = @"{"
@"\"total\": 1,"
@"\"page\": 1,"
@"\"pagesize\": 30,"
@"\"items\": ["
@"{"
@"\"tags\": ["
@"\"iphone\","
@"\"security\","
@"\"keychain\""
@"],"
@"\"answer_count\": 1,"
@"\"accepted_answer_id\": 3231900,"
@"\"favorite_count\": 1,"
@"\"question_timeline_url\": \"/questions/2817980/timeline\","
@"\"question_comments_url\": \"/questions/2817980/comments\","
@"\"question_answers_url\": \"/questions/2817980/answers\","
@"\"question_id\": 2817980,"
@"\"owner\": {"
@"\"user_id\": 23743,"
@"\"user_type\": \"registered\","
@"\"display_name\": \"Igor Fedorchuk\","
@"\"profile_image\": \"http://graph.facebook.com/863798233670142/picture?type=large\","
@"\"reputation\": 13459,"
@"\"email_hash\": \"563290c0c1b776a315b36e863b388a0c\""
@"},"
@"\"creation_date\": 1273660706,"
@"\"last_activity_date\": 1278965736,"
@"\"up_vote_count\": 2,"
@"\"down_vote_count\": 0,"
@"\"view_count\": 465,"
@"\"score\": 2,"
@"\"community_owned\": false,"
@"\"title\": \"Why does Keychain Services return the wrong keychain content?\","
@"\"body\": \"<p>I've been trying to use persistent keychain references.</p>\""
@"}"
@"]"
@"}";

SPEC_BEGIN(IFQuestionBuilderSpec)

describe(@"IFQuestionBuilderSpec", ^
{
    context(@"a state the component is in", ^
    {
        __block IFQuestionBuilder *builder = nil;
        
        beforeEach(^
        {
            builder = [IFQuestionBuilder new];
        });
        
        afterEach(^
        { 
        });

        it(@"should parse JSON", ^
        {
            NSData *data = [questionJSON dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            //NSDictionary *json = [questionJSON objectFromJSONString];
            NSArray *questions = [builder questionsFromJSON:json];
            IFQuestion *question = [questions objectAtIndex:0];
            
            [[theValue(question.questionID) should] equal:theValue(2817980)];
            [[theValue([question.date timeIntervalSince1970]) should] equal:theValue(1273660706)];
            [[question.title should] equal:@"Why does Keychain Services return the wrong keychain content?"];
            [[theValue(question.score) should] equal:theValue(2)];

            IFPerson *asker = question.asker;
            [[asker.name should] equal:@"Igor Fedorchuk"];
            [[[asker.avatarURL absoluteString] should] equal:@"http://graph.facebook.com/863798233670142/picture?type=large"];
        });
        
        it(@"should process fake JSON", ^
        {
            NSDictionary *fakeJson = nil;
            NSArray *questions = [builder questionsFromJSON:fakeJson];
            [[questions should] haveCountOf:0];
            
            fakeJson = [NSDictionary dictionary];
            questions = [builder questionsFromJSON:fakeJson];
            [[questions should] haveCountOf:0];
        });
        
    });
});

SPEC_END
