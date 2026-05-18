// NoIGBetaNag - Kill Instagram TestFlight "update beta" popup

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// ObjC classes
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

// Swift nag plugin
%hook IGCoreRootTestFlightNagPlugin
- (void)start { return; }
- (void)didBecomeActive { return; }
%end

// Swift nudge view controller
%hook TestFlightUpdateNudgeViewController
- (void)viewDidLoad { return; }
- (void)viewWillAppear:(BOOL)a { return; }
%end

// Swift build gate
%hook IGTestFlightBuildGate
- (BOOL)shouldGate { return NO; }
%end

// Block any UIViewController presentation with "TestFlight" in the class name
%hook UIViewController
- (void)presentViewController:(UIViewController *)vc animated:(BOOL)flag completion:(id)completion {
    NSString *cls = NSStringFromClass([vc class]);
    if ([cls containsString:@"TestFlight"] || [cls containsString:@"testflight"] || [cls containsString:@"UpdateNudge"]) {
        if (completion) ((void(^)(void))completion)();
        return;
    }
    %orig;
}
%end
