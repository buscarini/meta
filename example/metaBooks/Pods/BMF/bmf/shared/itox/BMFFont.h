//
//  JMSFont.h
//  iExample
//
//  Created by Jose Manuel Sánchez Peñarroja on 29/01/14.
//  Copyright (c) 2014 JMS. All rights reserved.
//

#import "BMFPlatform.h"

#if TARGET_OS_IPHONE
@interface BMFFont : UIFont
#else
@interface BMFFont : NSFont
#endif

@end
