
@interface PSListController : NSObject 
{ //Good enough
    id _specifiers;
}
- (id)loadSpecifiersFromPlistName:(NSString *)name target:(id)target;
@end

static CFNotificationCenterRef darwinNotifyCenter = CFNotificationCenterGetDarwinNotifyCenter();

@interface CCFakeLowBatteryListController: PSListController
@end

@implementation CCFakeLowBatteryListController

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"CCFakeLowBattery" target:self] retain];
	}
	return _specifiers;
}

-(void)donateMe
{
	NSURL *url = [[NSURL alloc] initWithString: @"https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=walkthej0hnny@gmail.com&lc=TW&item_name=Fake&nbsp;Low&nbsp;Battery&nbsp;CCToggles&amount=1.00&currency_code=USD&button_subtype=services&bn=PP-BuyNowBF:btn_buynowCC_LG_wCUP.gif:NonHosted"];
    [[UIApplication sharedApplication] openURL:url];
}
@end

