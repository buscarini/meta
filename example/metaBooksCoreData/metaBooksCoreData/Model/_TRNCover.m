// Generated Automatically: Any changes will be overwritten

#import "_TRNCover.h"

#import <BMF/BMFUtils.h>
#import <BMF/BMFTaskProtocol.h>
#import <BMF/BMFTaskManager.h>

#import <MagicalRecord/CoreData+MagicalRecord.h>

@implementation _TRNCover

@dynamic id;
@dynamic imageUrl;
@dynamic imageData;
@synthesize image;

@dynamic book;

- (void) setImageUrl:(NSString *)imageUrl {
	[self willChangeValueForKey:@"imageUrl"];
	[self setPrimitiveValue:imageUrl forKey:@"imageUrl"];
	[self didChangeValueForKey:@"imageUrl"];
	
	self.imageData = nil;
	[self p_loadImageUrl:^(id result, NSError *error) {
		
	}];
}

- (BMFIXImage *) image {
	BMFIXImage *result = [BMFManagedObject cachedObjectWithKey:self.imageUrl];
	if (!result && self.imageData) {
		[self p_unarchiveImageData:self.imageData completion:nil];
	}
	
	return result;
}

- (void) p_unarchiveImageData:(NSData *)data completion:(BMFCompletionBlock)block {
	BMFAssertReturn(data);
	
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		BMFIXImage *imageImageValue = [BMFUtils unarchiveImage:data];
		dispatch_async(dispatch_get_main_queue(),^{
			[BMFManagedObject setCachedObject:imageImageValue key:self.imageUrl];
			if (block) block(imageImageValue,nil);
		});
	});
}

- (void) p_loadImageUrl: (BMFCompletionBlock) block {
	if (!self.imageData && self.imageUrl) {
		id<BMFTaskProtocol> task = [[BMFBase sharedInstance].factory dataLoadTask:self.imageUrl parameters:nil sender:self];
		[self.taskManager addTask:task];
		
		[task start:^(NSData *result, NSError *error) {
			dispatch_async(dispatch_get_global_queue(0, 0), ^{
				UIImage *imageImageValue = [UIImage imageWithData:result];
				[self.managedObjectContext performBlock:^() {
					
//					[self.managedObjectContext refreshObject:self mergeChanges:YES];
					
					if (imageImageValue) [BMFManagedObject setCachedObject:imageImageValue key:self.imageUrl];
					
					if (self.BMF_isDeleted) {
						return;
					}
					
					if (!error && imageImageValue) {
						self.imageData = [BMFUtils archiveImage:imageImageValue];
						
						DDLogInfo(@"Updated image data: %@",self);
						
						if (block) block(imageImageValue,nil);
					}
					else {
						DDLogError(@"Error loading image: %@",error);
						if (block) block(nil,error);
					}
				}];
			});
		}];

	}
}

- (void) loadImage: (BMFCompletionBlock) block {

	BMFIXImage *cachedImage = [BMFManagedObject cachedObjectWithKey:self.imageUrl];
	if (cachedImage) {
		if (block) block(cachedImage,nil);
		return;
	}

	NSData *data = self.imageData;
	if (data) {
		[self p_unarchiveImageData:data completion:block];
	}
	else {
		if (self.imageUrl) {
			[self p_loadImageUrl:^(BMFIXImage *result,NSError *error){
				if (result) {
					if (block) block(result,nil);
				}
			}];
		}
		else {
			if (block) block(nil,[NSError errorWithDomain:@"Data Load" code:BMFErrorLacksRequiredData userInfo:@{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"No image url in object: %@",self] }]);
		}
	}
}

@end
