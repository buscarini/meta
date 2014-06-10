// Generated Automatically: Any changes will be overwritten

#import "_TRNCover.h"

#import <BMF/BMFUtils.h>
#import <BMF/BMFTaskProtocol.h>
#import <BMF/BMFTaskManager.h>

@implementation _TRNCover

@dynamic id;
@dynamic imageUrl;
@dynamic imageData;
@synthesize image;

@dynamic book;

- (void) setImageData:(NSData *) value {
	if (!value) {
		[self willChangeValueForKey:@"imageData"];
		[self setPrimitiveValue:nil forKey:@"imageData"];
		[self didChangeValueForKey:@"imageData"];
	}
	else {
		[self p_convertImageData:value completion:^(NSData *result, NSError *error) {
			[self willChangeValueForKey:@"imageData"];
			[self setPrimitiveValue:result forKey:@"imageData"];
			[self didChangeValueForKey:@"imageData"];
		}];
	}
}

- (void) setImageUrl:(NSString *)imageUrl {
	[self willChangeValueForKey:@"imageUrl"];
	[self setPrimitiveValue:imageUrl forKey:@"imageUrl"];
	[self didChangeValueForKey:@"imageUrl"];
	
	self.imageData = nil;
	[self p_loadImageUrl:^(id result, NSError *error) {
		
	}];
}

- (void) setImage:(BMFIXImage *) value {
	[self willChangeValueForKey:@"image"];
	[self setPrimitiveValue:[BMFUtils archiveImage:value] forKey:@"image"];
	[self didChangeValueForKey:@"image"];
}

- (BMFIXImage *) image {
	return [BMFUtils unarchiveImage:self.imageData];
}

- (void) p_unarchiveImageData:(NSData *)data completion:(BMFCompletionBlock)block {
	BMFAssertReturn(data);
	
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		BMFIXImage *imageImageValue = [BMFUtils unarchiveImage:data];
		dispatch_async(dispatch_get_main_queue(),^{
			block(imageImageValue,nil);
		});
	});
}

- (void) p_convertImageData:(NSData *) data completion:(BMFCompletionBlock)block {
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		UIImage *imageImageValue = [UIImage imageWithData:data];
		NSData *finalData = [BMFUtils archiveImage:imageImageValue];
		[self.managedObjectContext performBlock:^() {
			block(finalData,nil);
		}];
	});
}

- (void) p_loadImageUrl: (BMFCompletionBlock) block {
	if (!self.imageData && self.imageUrl) {
		id<BMFTaskProtocol> task = [[BMFBase sharedInstance].factory dataLoadTask:self.imageUrl parameters:nil sender:self];
		[self.taskManager addTask:task];
		
		[task start:^(NSData *result, NSError *error) {
			if (self.BMF_isDeleted) return;
			
			if (!error && result) {
				self.imageData = result;
				NSError *saveError = nil;
				if (![self.managedObjectContext save:&saveError]) {
					DDLogError(@"Error saving context after loading image data: %@",saveError);
				}
			}
			else {
				DDLogError(@"Error loading image: %@",error);
				if (block) block(nil,error);
			}
		}];

	}
}

- (void) loadImage: (BMFCompletionBlock) block {
	
	NSData *data = self.imageData;
	if (data) {
		[self p_unarchiveImageData:data completion:block];
	}
	else {
		if (self.imageUrl) {
			[self p_loadImageUrl:^(id result,NSError *error){
				if (result) {
					dispatch_async(dispatch_get_global_queue(0, 0), ^{
						UIImage *unpackedImage = [UIImage imageWithData:result];
						dispatch_async(dispatch_get_main_queue(), ^{
							if (block) block(unpackedImage,nil);
						});
					});
				}
			}];
		}
	}
}

@end
