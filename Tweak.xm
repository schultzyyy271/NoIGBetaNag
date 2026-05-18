#import <Foundation/Foundation.h>

%hook IGTestFlightNagController
- (id)init { return nil; }
%end

%hook IGTestFlightUpdateNagController
- (id)init { return nil; }
- (void)start { return; }
%end

%hook IGTestFlightCheckForUpdatesBackgroundJob
- (void)performWithCompletion:(id)arg1 {
    if (arg1) ((void(^)(BOOL))arg1)(YES);
}
%end
