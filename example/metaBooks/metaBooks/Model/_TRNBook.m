// Generated Automatically: Any changes will be overwritten

#import "_TRNBook.h"

@implementation _TRNBook

@synthesize id=_id;
@synthesize title=_title;
@synthesize author=_author;
@synthesize numPages=_numPages;
@synthesize purchaseDate=_purchaseDate;
@synthesize deleted=_deleted;

#pragma mark Encode - Decode

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
		_id = [coder decodeInt32ForKey:@"_TRNBook_id"];
		_title = [coder decodeObjectForKey:@"_TRNBook_title"];
		_author = [coder decodeObjectForKey:@"_TRNBook_author"];
		_numPages = [coder decodeInt32ForKey:@"_TRNBook_numPages"];
		_purchaseDate = [coder decodeObjectForKey:@"_TRNBook_purchaseDate"];
		_deleted = [coder decodeBoolForKey:@"_TRNBook_deleted"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeInt32:self.id forKey:@"_TRNBook_id"];
    [coder encodeObject:self.title forKey:@"_TRNBook_title"];
    [coder encodeObject:self.author forKey:@"_TRNBook_author"];
    [coder encodeInt32:self.numPages forKey:@"_TRNBook_numPages"];
    [coder encodeObject:self.purchaseDate forKey:@"_TRNBook_purchaseDate"];
    [coder encodeBool:self.deleted forKey:@"_TRNBook_deleted"];
}

#pragma mark Accessors

- (void) setId:(NSInteger) id {
	[self willChangeValueForKey:@"id"];
	if (_id!=id) {
		_id = id;
	}
	[self didChangeValueForKey:@"id"];
}

- (NSInteger) id {
	return _id;
}

- (void) setTitle:(NSString *) title {
	[self willChangeValueForKey:@"title"];
	if (_title!=title) {
		_title = title;
	}
	[self didChangeValueForKey:@"title"];
}

- (NSString *) title {
	return _title;
}

- (void) setAuthor:(NSString *) author {
	[self willChangeValueForKey:@"author"];
	if (_author!=author) {
		_author = author;
	}
	[self didChangeValueForKey:@"author"];
}

- (NSString *) author {
	return _author;
}

- (void) setNumPages:(NSInteger) numPages {
	[self willChangeValueForKey:@"numPages"];
	if (_numPages!=numPages) {
		_numPages = numPages;
	}
	[self didChangeValueForKey:@"numPages"];
}

- (NSInteger) numPages {
	return _numPages;
}

- (void) setPurchaseDate:(NSDate *) purchaseDate {
	[self willChangeValueForKey:@"purchaseDate"];
	if (_purchaseDate!=purchaseDate) {
		_purchaseDate = purchaseDate;
	}
	[self didChangeValueForKey:@"purchaseDate"];
}

- (NSDate *) purchaseDate {
	return _purchaseDate;
}

- (void) setDeleted:(BOOL) deleted {
	[self willChangeValueForKey:@"deleted"];
	if (_deleted!=deleted) {
		_deleted = deleted;
	}
	[self didChangeValueForKey:@"deleted"];
}

- (BOOL) deleted {
	return _deleted;
}


@end
