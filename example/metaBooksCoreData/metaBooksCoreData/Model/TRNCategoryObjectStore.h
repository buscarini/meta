#import <Foundation/Foundation.h>

#import <BMF/BMFManagedObjectDataStore.h>

#import "TRNCategory.h"

@interface TRNCategoryObjectStore : BMFManagedObjectDataStore

@property (nonatomic, strong) TRNCategory *object;

@end
