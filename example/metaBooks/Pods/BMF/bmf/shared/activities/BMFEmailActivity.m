//
//  BMFEmailActivity.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFEmailActivity.h"

#import "BMF.h"
#import "BMFUtils.h"

#if TARGET_OS_IPHONE
#import <MessageUI/MessageUI.h>
#import "BMFAlertView.h"
#endif

@interface BMFEmailActivity()
#if TARGET_OS_IPHONE
<MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) MFMailComposeViewController *emailVC;
#endif

@property (nonatomic, copy) BMFCompletionBlock completionBlock;

@end

@implementation BMFEmailActivity

- (NSString *) mailtoUrlString {
	
	NSMutableString *result = [NSMutableString string];
//	[result appendString:@"mailto:"];
		
	NSArray *emails = [self emails];
	[result appendString:[emails componentsJoinedByString:@"%2C%20"]];
	
	NSString *stringValue = [NSString BMF_cast:self.value];
	if (stringValue.length>0) [result appendString:stringValue];
	
	[result appendString:@"?"];
	
	if (self.cc.count>0) [result appendFormat:@"cc=%@&amp;",[self.cc componentsJoinedByString:@"%2C%20"]];
	if (self.subject.length>0) [result appendFormat:@"subject=%@&amp;",self.subject];
	if (self.body.length>0) [result appendFormat:@"body=%@&amp;",self.body];
	
	NSString *finalResult = [BMFUtils escapeURLString:result];
	
	return [@"mailto:" stringByAppendingString:finalResult];
}

- (NSArray *) emails {
	NSArray *values = [NSArray BMF_cast:self.value];
	if (values) return values;
	
	if (self.value) return @[ self.value ];
	
	return nil;
}

- (void) run:(BMFCompletionBlock)completionBlock {
	#if !TARGET_OS_IPHONE
	self.openExternalApp = NO;
#endif
	
	
	if (self.openExternalApp) {
		
		
		NSString *finalUrlString = [self mailtoUrlString];
		
		BOOL result = [BMFApplication openURL:[NSURL URLWithString:finalUrlString]];
//		BOOL result = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:finalUrlString]];
		NSError *error = nil;
		if (!result) error = [NSError errorWithDomain:@"Email activity" code:BMFErrorUnknown userInfo:@{ NSLocalizedDescriptionKey : [NSString  stringWithFormat:BMFLocalized(@"Failed to open mailto url: %@", nil),finalUrlString] }];
		
		if (completionBlock) completionBlock(nil,error);
	}
	else {
	
#if TARGET_OS_IPHONE
		
		BMFAssertReturn(self.viewController);

//		if (!self.viewController) {
//			[NSException raise:@"Can't perform email activity without viewcontroller" format:@"%@",self];
//			return;
//		}
		
		self.emailVC = [[MFMailComposeViewController alloc] init];
		self.emailVC.mailComposeDelegate = self;

		NSArray *emails = [self emails];
		
		if (emails && emails.count>0) [self.emailVC setToRecipients:emails];
		[self.emailVC setCcRecipients:self.cc];
		[self.emailVC setSubject:self.subject];
		[self.emailVC setMessageBody:self.body isHTML:NO];
		
		if (completionBlock) self.completionBlock = completionBlock;
		
		[self.viewController presentViewController:self.emailVC animated:YES completion:nil];
#endif
	}
}

#if TARGET_OS_IPHONE

#pragma mark MFMailComposeViewControllerDelegate

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	NSLog(@"did finish with result");
	if ( result == MFMailComposeResultFailed )
	{
		// Sending failed - display an error message to the user.
		NSString *message = [NSString stringWithFormat:BMFLocalized(@"Error sending email '%@'. Please try again, or cancel the operation.",nil), [error localizedDescription]];

		BMFAlertView *alertView = [[BMFAlertView alloc] initWithTitle:@"Error Sending Email" message:message];
		[alertView BMF_addCancelButtonWithTitle:BMFLocalized(@"Cancel", nil) actionBlock:^(id sender) {
			if (self.completionBlock) self.completionBlock(@(result),error);
			self.completionBlock = nil;
		}];
		
		[alertView show];
	}
	else
	{
		// If we got here - everything should have gone as the user wanted - dismiss the modal view.
		if (self.emailVC) [self.emailVC dismissViewControllerAnimated:YES completion:nil];
		if (self.completionBlock) self.completionBlock(@(result),error);
		self.completionBlock = nil;
	}
}

#endif


@end
