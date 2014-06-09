// Generated Automatically: Any changes will be overwritten

#import "_TRNCover.h"

@implementation _TRNCover

@dynamic id;
@dynamic imageUrl;
@dynamic image;

@dynamic book;

- (void) setImage:(BMFIXImage *) value {
	[self willChangeValueForKey:@"image"];
	[self setPrimitiveValue:[self.class archiveImage:value] forKey:@"image"];
	[self didChangeValueForKey:@"image"];
}

- (BMFIXImage *) image {
	return [self.class unarchiveImage:self.image];
}

@end
