#import "CCTogglesAgent.h"
#include <notify.h>

@interface SBUIController
-(int)displayBatteryCapacityAsPercentage;
+(id)sharedInstance;
-(void)updateBatteryState:(id)arg1;
@end

@interface SBStatusBarStateAggregator
+ (id)sharedInstance;
- (void)_updateBatteryItems;
@end

BOOL state;
NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.johnnychian.fakelowbatt.plist"];

%hook SBUIController
-(int)displayBatteryCapacityAsPercentage
{
	int percentage = (!plist) ? 10 : [[plist objectForKey:@"percentage"] intValue];
	if (state == YES) {
		return percentage;
	} else {
		return %orig;
	}
	return %orig;
}

- (void)updateBatteryState:(id)arg1
{
	%orig;
}
%end

%hook SBStatusBarStateAggregator
- (void)_updateBatteryItems
{
	%orig;
}
%end

@interface iNoBattToggleCCToggle : NSObject <CCTogglesDataSource>
@end

@implementation iNoBattToggleCCToggle

- (CCToggleState)getState 
{
	// Register notification
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), //center
                                (void*)self, // observer
                                onPreferencesChanged, // callback
                                CFSTR("com.johnnychian.fakelowbatt-preferencesChanged"), // event name
                                NULL, // object
                                CFNotificationSuspensionBehaviorDeliverImmediately);
	return (CCToggleState)state;
}

- (void)setState:(BOOL)newState 
{
	NSBundle *selfBundle = [NSBundle bundleForClass:[iNoBattToggleCCToggle class]];
	state = newState;

	if (state == YES) {
		[[%c(CCTogglesAgent) sharedInstance] updateStatusText:@"Fake battery percent" forIdentifier:selfBundle.bundleIdentifier];
	} else {
		[[%c(CCTogglesAgent) sharedInstance] updateToggleStatusForIdentifier:selfBundle.bundleIdentifier];	
		[[%c(CCTogglesAgent) sharedInstance] updateStatusText:@"Original battery percent" forIdentifier:selfBundle.bundleIdentifier];
	}
	[(SBStatusBarStateAggregator *)[%c(SBStatusBarStateAggregator) sharedInstance] _updateBatteryItems];
}

// Handle preference changed notification
static void onPreferencesChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) 
{
	// Reload plist
	plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.johnnychian.fakelowbatt.plist"];
	[(SBStatusBarStateAggregator *)[%c(SBStatusBarStateAggregator) sharedInstance] _updateBatteryItems];
}

@end