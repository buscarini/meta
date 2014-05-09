//
//  BMFTextFieldSwipeAspect.m
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 25/04/14.
//
//

#import "BMFTextFieldSwipeAspect.h"

#import "BMFTypes.h"

@interface BMFTextFieldSwipeAspect()

@property (nonatomic, strong) NSString *lastText;

@end

@implementation BMFTextFieldSwipeAspect

- (void) setObject:(id)object {
	BMFAssertReturn([object respondsToSelector:@selector(setText:)]);
	BMFAssertReturn([object respondsToSelector:@selector(text)]);
	
	BMFAddDisposableProperty(self, lastText);
		
	[super setObject:object];
	
	UISwipeGestureRecognizer *searchRightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(searchSwipeRight:)];
	[object addGestureRecognizer:searchRightSwipeRecognizer];
	
	UISwipeGestureRecognizer *searchLeftSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(searchSwipeLeft:)];
	searchLeftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
	[object addGestureRecognizer:searchLeftSwipeRecognizer];
}

- (void) searchSwipeRight: (UIGestureRecognizer *) recognizer {

	NSString *text = [self.object performSelector:@selector(text)];
	
	if (text.length>0) return;
	
	[self.object performSelector:@selector(setText:) withObject:self.lastText];
		
	UISearchBar *searchBar = [UISearchBar BMF_cast:self.object];
	[searchBar.delegate searchBar:searchBar textDidChange:self.lastText];
}

- (void) searchSwipeLeft: (UIGestureRecognizer *) recognizer {
	
	self.lastText = [self.object performSelector:@selector(text)];
	[self.object performSelector:@selector(setText:) withObject:@""];

	UISearchBar *searchBar = [UISearchBar BMF_cast:self.object];
	[searchBar.delegate searchBar:searchBar textDidChange:self.lastText];
}


@end
