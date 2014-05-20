#import <Foundation/Foundation.h>

#import <BMF/BMFManagedObjectDataStore.h>

#import "TRNBook.h"

@interface TRNBookObjectStore : BMFManagedObjectDataStore

@property (nonatomic, strong) TRNBook *object;

@end
