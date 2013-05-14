#import "../Frameworks/Tuneup/tuneup.js"

test("Test title", function(target, app)
     {
     var window = app.mainWindow();
     app.logElementTree();
     
     UIALogger.logMessage( "Get title text" );
     
     var navigationBar = app.navigationBar();
     var title = navigationBar.name();
     assertEquals("Iphone tag", title);
     });

