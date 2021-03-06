// Generated Automatically: Any changes will be overwritten

#import <Foundation/Foundation.h>

#import <BMF/BMFManagedObject.h>
#import <BMF/BMF.h>

@class _TRNBook;

@interface _TRNCategory : BMFManagedObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSSet *books;

@end

@interface _TRNCategory (CoreDataGeneratedAccessors)

- (void)addBooksObject:(_TRNBook *)value;
- (void)removeBooksObject:(_TRNBook *)value;
- (void)addBooks:(NSSet *)values;
- (void)removeBooks:(NSSet *)values;

@end
