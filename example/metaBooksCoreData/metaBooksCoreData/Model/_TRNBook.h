// Generated Automatically: Any changes will be overwritten

#import <Foundation/Foundation.h>


@class _TRNCategory;

@interface _TRNBook : NSManagedObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, assign) NSInteger numPages;
@property (nonatomic, strong) NSDate *purchaseDate;
@property (nonatomic, assign) BOOL deleted;
@property (nonatomic, strong) _TRNCategory *category;

@end

@interface _TRNBook (CoreDataGeneratedAccessors)


@end
