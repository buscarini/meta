//
//  BMFSimpleViewRegister.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFSimpleViewRegister.h"

#import "BMFTypes.h"

#import "UICollectionView+BMF.h"

#import <objc/runtime.h>

@interface BMFSimpleViewRegister()

@property (nonatomic, strong) NSMutableDictionary *viewsDic;

@end

@implementation BMFSimpleViewRegister

- (NSString *) viewIdentifierForKind:(BMFViewKind) kind indexPath:(NSIndexPath *)indexPath {
	BMFViewRegisterInfo *info = [self.viewsDic objectForKey:@(kind)];
	return info.viewId;
}

- (id) classOrUINibForKind:(BMFViewKind) kind indexPath:(NSIndexPath *)indexPath {
	BMFViewRegisterInfo *info = [self.viewsDic objectForKey:@(kind)];
	return info.classOrUINib;
}

- (instancetype) initWithInfos:(NSArray *) infos {
    self = [super init];
    if (self) {
		self.viewsDic = [NSMutableDictionary dictionary];
		[infos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			BMFViewRegisterInfo *info = [BMFViewRegisterInfo BMF_cast:obj];
			
			[self.viewsDic setObject:info forKey:@(info.kind)];
		}];
    }
    return self;
}

- (void) registerTableViews:(UITableView *)tableView {
	[self.viewsDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		BMFViewRegisterInfo *info = obj;
		if ([info.classOrUINib isKindOfClass:[UINib class]]) {
			[tableView registerNib:info.classOrUINib forHeaderFooterViewReuseIdentifier:info.viewId];
		}
		else if (class_isMetaClass(object_getClass(info.classOrUINib))) {
			[tableView registerClass:info.classOrUINib forHeaderFooterViewReuseIdentifier:info.viewId];
		}
	}];
}

- (void) registerCollectionViews:(UICollectionView *)collectionView {
	[self.viewsDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		BMFViewRegisterInfo *info = obj;
		
		NSString *kindString = [UICollectionView BMF_kindStringFromKind:info.kind];
				
		if ([info.classOrUINib isKindOfClass:[UINib class]]) {
			[collectionView registerNib:info.classOrUINib forSupplementaryViewOfKind:kindString withReuseIdentifier:info.viewId];
		}
		else if (class_isMetaClass(object_getClass(info.classOrUINib))) {
			[collectionView registerClass:info.classOrUINib forSupplementaryViewOfKind:kindString withReuseIdentifier:info.viewId];
		}
	}];
}

@end
