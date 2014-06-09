// Generated Automatically: Any changes will be overwritten

#import <Foundation/Foundation.h>

#import <BMF/BMFManagedObject.h>

@class _TRNBook;

@interface _TRNCover : BMFManagedObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) BMFIXImage *image;
@property (nonatomic, strong) _TRNBook *book;

@end

@interface _TRNCover (CoreDataGeneratedAccessors)


@end
