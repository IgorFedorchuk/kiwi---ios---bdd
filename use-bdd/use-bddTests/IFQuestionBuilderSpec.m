#import "Kiwi.h"
#import "IFQuestionBuilder.h"
#import "JSONKit.h"
#import "IFQuestion.h"

//JSON example
static NSString *questionJSON = @"{"
@"\"total\": 1,"
@"\"page\": 1,"
@"\"pagesize\": 30,"
@"\"questions\": ["
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
@"\"display_name\": \"Graham Lee\","
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
            NSDictionary *json = [questionJSON objectFromJSONString];
            NSArray *questions = [builder receivedJSON:json];
            IFQuestion *question = [questions objectAtIndex:0];
            
            [[theValue(question.questionID) should] equal:theValue(2817980)];
            [[theValue([question.date timeIntervalSince1970]) should] equal:theValue(1273660706)];
            [[question.title should] equal:@"Why does Keychain Services return the wrong keychain content?"];
            [[theValue(question.score) should] equal:theValue(2)];

            /*
            
            Person *asker = question.asker;
            STAssertEqualObjects(asker.name, @"Graham Lee", @"Looks like I should have asked this question");
            STAssertEqualObjects([asker.avatarURL absoluteString], @"http://www.gravatar.com/avatar/563290c0c1b776a315b36e863b388a0c", @"The avatar URL should be based on the supplied email hash");*/
        });
        
    });
});

SPEC_END
