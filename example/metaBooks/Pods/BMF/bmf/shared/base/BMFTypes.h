
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else

#endif

#pragma mark Assertions

#define BMFAssertReturn(condition) do{ NSAssert((condition), @"Invalid condition not satisfying: %s", #condition);\
if(!(condition)) { DDLogError(@"Invalid condition not satisfying: %s", #condition); return;} } while(0)

#define BMFAssertReturnZero(condition) do{ NSAssert((condition), @"Invalid condition not satisfying: %s", #condition);\
if(!(condition)) { DDLogError(@"Invalid condition not satisfying: %s", #condition); return 0;} } while(0)

#define BMFAssertReturnNO(condition) do{ NSAssert((condition), @"Invalid condition not satisfying: %s", #condition);\
if(!(condition)) { DDLogError(@"Invalid condition not satisfying: %s", #condition); return NO;} } while(0)

#define BMFAssertReturnNil(condition) do{ NSAssert((condition), @"Invalid condition not satisfying: %s", #condition);\
if(!(condition)) { DDLogError(@"Invalid condition not satisfying: %s", #condition); return nil;} } while(0)

#define BMFInvalidInit(correctInitName) do { [NSException raise:@"Invalid constructor; some parameters are needed. Use " #correctInitName " instead" format:nil]; return nil; } while (0)


#pragma mark Constants

#define BMFLocalConstant(type,name,value) static const type name = value;
#define BMFDeclareGlobalConstant(type,name,value) extern type const name = value;
#define BMFDefineGlobalConstant(type,name,value) type const name = value;
#define BMFDeclareGlobalNotificationConstant(name) extern NSString *const name;
#define BMFDefineGlobalNotificationConstant(name) NSString *const name = @"" # name;

#pragma mark Base classes cross platform defines

#if TARGET_OS_IPHONE

#define BMFIXView UIView
#define BMFIXImage UIImage
#define BMFIXColor UIColor
#define BMFIXFont UIFont
#define BMFIXPasteboard UIPasteboard

#define BMFApplicationDidChangeOrientationNotification UIApplicationDidChangeStatusBarOrientationNotification
#define BMFApplicationWillTerminateNotification UIApplicationWillTerminateNotification

#else

#define BMFIXView NSView
#define BMFIXImage NSImage
#define BMFIXColor NSColor
#define BMFIXFont NSFont
#define BMFIXPasteboard NSPasteboard

//#define BMFApplicationDidChangeOrientationNotification nil
#define BMFApplicationWillTerminateNotification NSApplicationWillTerminateNotification

#endif

#pragma mark Blocks

typedef void(^BMFBlock)();
typedef void(^BMFCompletionBlock)(id result,NSError *error);
typedef void(^BMFActionBlock)(id sender);
typedef void(^BMFOperationBlock)(id sender,BMFCompletionBlock completionBlock);

#define BMFSuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


typedef NS_ENUM(NSInteger, BMFErrorCodes) {
	BMFErrorUnknown,
	BMFErrorAssertion,
	BMFErrorFiltered,
	BMFErrorCancelled,
	BMFErrorData,
	BMFErrorLoad,
	BMFErrorLacksRequiredData,
	BMFErrorInvalidType
};

#pragma mark Enums

enum {
    BMFLayoutPriorityRequired = 1000,
    BMFLayoutPriorityDefaultHigh = 750,
    BMFLayoutPriorityDragThatCanResizeWindow = 510,
    BMFLayoutPriorityWindowSizeStayPut = 500,
    BMFLayoutPriorityDragThatCannotResizeWindow = 490,
    BMFLayoutPriorityDefaultLow = 250,
    BMFLayoutPriorityFittingSizeCompression = 50
};
typedef float BMFLayoutPriority;

typedef NS_ENUM(NSInteger, BMFDeviceFamily) {
    BMFDeviceFamilyIPad,
    BMFDeviceFamilyIPhone,
    BMFDeviceFamilyMac
};

typedef NS_ENUM(NSInteger, BMFDeviceOrientationAxis) {
	BMFDeviceOrientationAxisUnknown,
	BMFDeviceOrientationAxisPortrait,
	BMFDeviceOrientationAxisLandscape
};

#if TARGET_OS_IPHONE

typedef NS_ENUM(NSUInteger, BMFTextAlignment) {
	BMFTextAlignmentLeft = NSTextAlignmentLeft,
	BMFTextAlignmentCenter = NSTextAlignmentCenter,
	BMFTextAlignmentRight = NSTextAlignmentRight,
	BMFTextAlignmentJustified = NSTextAlignmentJustified,
	BMFTextAlignmentNatural = NSTextAlignmentNatural,
};

typedef NS_ENUM(NSInteger, BMFLayoutConstraintAxis) {
	BMFLayoutConstraintAxisHorizontal = UILayoutConstraintAxisHorizontal,
    BMFLayoutConstraintAxisVertical = UILayoutConstraintAxisVertical
};

typedef NS_ENUM(NSInteger, BMFDeviceOrientation) {
	BMFDeviceOrientationUnknown = UIDeviceOrientationUnknown,
	BMFDeviceOrientationPortrait = UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
	BMFDeviceOrientationPortraitUpsideDown = UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
	BMFDeviceOrientationLandscapeLeft = UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
	BMFDeviceOrientationLandscapeRight = UIDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
	BMFDeviceOrientationFaceUp = UIDeviceOrientationFaceUp,              // Device oriented flat, face up
	BMFDeviceOrientationFaceDown = UIDeviceOrientationFaceDown             // Device oriented flat, face down
};


typedef NS_ENUM(NSInteger, BMFDeviceBatteryState) {
	BMFDeviceBatteryStateUnknown = UIDeviceBatteryStateUnknown,
	BMFDeviceBatteryStateUnplugged = UIDeviceBatteryStateUnplugged,   // on battery, discharging
	BMFDeviceBatteryStateCharging = UIDeviceBatteryStateCharging,    // plugged in, less than 100%
	BMFDeviceBatteryStateFull = UIDeviceBatteryStateFull,        // plugged in, at 100%
};

#else 

typedef NS_ENUM(NSUInteger, BMFTextAlignment) {
	BMFTextAlignmentLeft = NSLeftTextAlignment,
	BMFTextAlignmentCenter = NSCenterTextAlignment,
	BMFTextAlignmentRight = NSRightTextAlignment,
	BMFTextAlignmentJustified = NSJustifiedTextAlignment,
	BMFTextAlignmentNatural = NSNaturalTextAlignment
};

typedef NS_ENUM(NSInteger, BMFLayoutConstraintAxis) {
	BMFLayoutConstraintAxisHorizontal = 0,
    BMFLayoutConstraintAxisVertical = 1
};

typedef NS_ENUM(NSInteger, BMFDeviceOrientation) {
    BMFDeviceOrientationUnknown,
    BMFDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
    BMFDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
    BMFDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
    BMFDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
    BMFDeviceOrientationFaceUp,              // Device oriented flat, face up
    BMFDeviceOrientationFaceDown             // Device oriented flat, face down
};


typedef NS_ENUM(NSInteger, BMFDeviceBatteryState) {
	BMFDeviceBatteryStateUnknown,
	BMFDeviceBatteryStateUnplugged,   // on battery, discharging
	BMFDeviceBatteryStateCharging,    // plugged in, less than 100%
	BMFDeviceBatteryStateFull,        // plugged in, at 100%
};

#endif


typedef NS_ENUM(NSUInteger, BMFViewKind) {
	BMFViewKindSectionHeader,
	BMFViewKindSectionFooter,
	BMFViewKindCell
};

#pragma mark Notifications

BMFDeclareGlobalNotificationConstant(BMFDataWillChangeNotification);
BMFDeclareGlobalNotificationConstant(BMFDataSectionInsertedNotification);
BMFDeclareGlobalNotificationConstant(BMFDataSectionDeletedNotification);
BMFDeclareGlobalNotificationConstant(BMFDataInsertedNotification);
BMFDeclareGlobalNotificationConstant(BMFDataMovedNotification);
BMFDeclareGlobalNotificationConstant(BMFDataUpdatedNotification);
BMFDeclareGlobalNotificationConstant(BMFDataDeletedNotification);
BMFDeclareGlobalNotificationConstant(BMFDataDidChangeNotification);
BMFDeclareGlobalNotificationConstant(BMFDataBatchChangeNotification);

#pragma mark Imports

#import <CocoaLumberjack/DDLog.h>

#ifdef DEBUG
static int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static int ddLogLevel = LOG_LEVEL_DEBUG;
#endif

#import "NSObject+BMF.h"
#import "NSObject+BMFAspects.h"
#import "BMFConfigurationProtocol.h"
#import "NSString+BMF.h"
#import "BMFMutableWeakArray.h"
#import "NSIndexPath+BMF.h"

#import "BMFColor.h"
#import "BMFImage.h"
#import "BMFFont.h"
#import "BMFApplication.h"

#import "BMFDevice.h"


#if TARGET_OS_IPHONE
#import "UIView+BMF.h"
#import "UIViewController+BMF.h"
#import "UITableView+BMF.h"
#endif
