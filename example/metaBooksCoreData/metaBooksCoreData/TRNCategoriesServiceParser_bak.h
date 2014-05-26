#import <Foundation/Foundation.h>

#import <BMF/BMFParserProtocol.h>
#import <BMF/BMFProgress.h>


@interface TRNCategoriesServiceParser : NSObject <BMFParserProtocol>

@property (nonatomic, strong) BMFProgress *progress;

@end
