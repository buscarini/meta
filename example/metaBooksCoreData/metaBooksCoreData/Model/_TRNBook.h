// Generated Automatically: Any changes will be overwritten

#import <Foundation/Foundation.h>

#import <BMF/BMFManagedObject.h>

@class _TRNCategory, _TRNCover;

@interface _TRNBook : BMFManagedObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, assign) NSInteger numPages;
@property (nonatomic, strong) NSDate *purchaseDate;
@property (nonatomic, assign) BOOL deleted;
@property (nonatomic, strong) _TRNCategory *category;
@property (nonatomic, strong) _TRNCover *cover;

@end

@interface _TRNBook (CoreDataGeneratedAccessors)


@end
