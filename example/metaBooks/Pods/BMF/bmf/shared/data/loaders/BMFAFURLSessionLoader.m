//
//  TNAFNetworkingLoader.m
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFAFURLSessionLoader.h"

#import "BMF.h"

#import "BMFUtils.h"

#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <malloc/malloc.h>

static AFHTTPSessionManager *sessionManager = nil;

@interface BMFAFURLSessionLoader() <NSURLSessionDelegate,NSURLSessionTaskDelegate,NSURLSessionDataDelegate>
	@property (nonatomic, strong) NSURL *finalUrl;
@end

@implementation BMFAFURLSessionLoader {
	NSURLSessionDataTask *dataTask;
}

@synthesize progress = _progress;

- (id)init
{
    self = [super init];
    if (self) {
        self.configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
		_progress = [[BMFProgress alloc] init];
		_method = @"GET";
		
		#if TARGET_OS_IPHONE
		[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil] subscribeNext:^(id x) {
			[sessionManager invalidateSessionCancelingTasks:NO];
			sessionManager = nil;
		}];
		#endif
    }
    return self;
}

- (void) cancel {
	[dataTask cancel];
	[self.progress stop:nil];
}

- (void) load:(BMFCompletionBlock) completionBlock {
	
	BMFAssertReturn(self.url);
	BMFAssertReturn(completionBlock);
	
	@autoreleasepool {
//		if (!self.url) {
//			[NSException raise:BMFLocalized(@"Error loading. Url can't be nil",nil) format:@"%@",self];
//			return;
//		}
		
//		if (!completionBlock) {
//			[NSException raise:BMFLocalized(@"Error loading. Completion block can't be nil",nil) format:@"%@",self];
//			return;
//		}
		
		[_progress start];
		
		self.finalUrl = self.url;
		
		_progress.progressMessage = BMFLocalized(@"Loading data", nil);
		
		if (self.cache) {
			id responseObject = [self.cache objectForKey:self.url];
			if (responseObject) {
				DDLogInfo(@"Loader returning cached data");
				[_progress stop:nil];
				completionBlock(responseObject,nil);
				return;
			}
		}
		
		DDLogDebug(@"Load url: %@ params: %@",self.url.absoluteString,self.parameters);
		
		/*AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:self.configuration];
		 
		 [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition (NSURLSession *session, NSURLAuthenticationChallenge *challenge, NSURLCredential * __autoreleasing *credential) {
		 return NSURLSessionAuthChallengePerformDefaultHandling;
		 }];
		 
		 AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
		 serializer.acceptableContentTypes = self.acceptableContentTypes;
		 manager.responseSerializer = serializer;*/
		if (!sessionManager) sessionManager = [AFHTTPSessionManager manager];
		
		[sessionManager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition (NSURLSession *session, NSURLAuthenticationChallenge *challenge, NSURLCredential * __autoreleasing *credential) {
			return NSURLSessionAuthChallengePerformDefaultHandling;
		}];
		
		AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
		serializer.acceptableContentTypes = self.acceptableContentTypes;
		sessionManager.responseSerializer = serializer;
		
		
		//	NSURLRequest *request = [NSURLRequest requestWithURL:finalUrl];
		NSError *error = nil;
		NSMutableURLRequest *request = [sessionManager.requestSerializer requestWithMethod:self.method URLString:self.url.absoluteString parameters:self.parameters error:&error];
		if (error) {
			DDLogError(@"Error creating request: %@",error);
		}
		if (self.userAgent) {
			[request addValue:self.userAgent forHTTPHeaderField:@"User-Agent"];
		}
		
		dataTask = [sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
			
			[_progress stop:error];
			
			if (error) {
				completionBlock(nil,error);
			}
			else {	
				if (self.cache) {
					[self.cache setObject:responseObject forKey:self.url cost:malloc_size((__bridge const void *)(responseObject))];
				}
				
				completionBlock(responseObject,nil);
			}
		}];
		
		[sessionManager setTaskDidSendBodyDataBlock:^(NSURLSession *session, NSURLSessionTask *task, int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
			_progress.completedUnitCount = task.countOfBytesSent+task.countOfBytesReceived;
		}];
		
		[sessionManager setDataTaskDidReceiveResponseBlock:^NSURLSessionResponseDisposition(NSURLSession *session, NSURLSessionDataTask *task, NSURLResponse *response) {
			_progress.totalUnitCount = task.countOfBytesExpectedToSend + task.countOfBytesExpectedToReceive;
			return NSURLSessionResponseAllow;
		}];
		
		[sessionManager setDataTaskDidReceiveDataBlock:^(NSURLSession *session, NSURLSessionDataTask *task, NSData *data) {
			_progress.completedUnitCount = task.countOfBytesSent+task.countOfBytesReceived;
		}];
		
		[sessionManager setTaskWillPerformHTTPRedirectionBlock:^NSURLRequest *(NSURLSession *session, NSURLSessionTask *task, NSURLResponse *response, NSURLRequest *request) {
			self.finalUrl = request.URL;
			return request;
		}];
		
		[dataTask resume];
	}
}

- (NSURL *) finalUrl {
	
	NSMutableString *finalUrlString = [self.url.absoluteString mutableCopy];
	if (self.parameters.allKeys.count>0) [finalUrlString appendString:@"?"];
	
	[self.parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		NSString *escapedKey = [BMFUtils escapeURLString:key];
		NSString *escapedValue = [BMFUtils escapeURLString:obj];
		[finalUrlString appendString:escapedKey];
		[finalUrlString appendString:@"="];
		[finalUrlString appendString:escapedValue];
		[finalUrlString appendString:@"&"];
	}];
	
	return [NSURL URLWithString:finalUrlString];
}

@end
