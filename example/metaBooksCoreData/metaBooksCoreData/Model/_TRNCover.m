// Generated Automatically: Any changes will be overwritten

#import "_TRNCover.h"

#import <BMF/BMFUtils.h>

@implementation _TRNCover

@dynamic id;
@dynamic imageUrl;
@dynamic imageData;
@synthesize image;

@dynamic book;

- (void) setImageData:(NSData *) value {
	[self willChangeValueForKey:@"imageData"];
	if (!value) {
		[self setPrimitiveValue:nil forKey:@"imageData"];
		[self didChangeValueForKey:@"imageData"];
	}
	else {
		dispatch_async(dispatch_get_global_queue(0, 0), ^{	
			UIImage *imageImageValue = [UIImage imageWithData:value];
			[self.managedObjectContext performBlock:^() {
				[self setPrimitiveValue:[BMFUtils archiveImage:imageImageValue] forKey:@"imageData"];
				[self didChangeValueForKey:@"imageData"];
			}];
		});
	}
}

- (void) setImage:(BMFIXImage *) value {
	[self willChangeValueForKey:@"image"];
	[self setPrimitiveValue:[BMFUtils archiveImage:value] forKey:@"image"];
	[self didChangeValueForKey:@"image"];
}

- (BMFIXImage *) image {
	return [BMFUtils unarchiveImage:self.imageData];
}

- (void) loadImage: (BMFCompletionBlock) block {
	NSData *data = self.imageData;
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		BMFIXImage *imageImageValue = [BMFUtils unarchiveImage:data];
		dispatch_async(dispatch_get_main_queue(),^{
			block(imageImageValue,nil);
		});
	});
}

@end
