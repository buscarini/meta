// Generated Automatically: Any changes will be overwritten

#import <Foundation/Foundation.h>

#import <BMF/BMFManagedObject.h>
#import <BMF/BMF.h>

@class _TRNBook;

@interface _TRNCover : BMFManagedObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) NSData *imageData;

@property (nonatomic, readonly) BMFIXImage *image;

@property (nonatomic, strong) _TRNBook *book;

- (void) loadImage: (BMFCompletionBlock) block;

@end

@interface _TRNCover (CoreDataGeneratedAccessors)


@end
