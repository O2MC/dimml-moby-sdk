//
//  O2MEventManager.m
//  datastreams
//
//  Created by Tim Slot on 18/07/2018.
//  Copyright © 2018 Adversitement. All rights reserved.
//

#import "O2MEventManager.h"

@implementation O2MEventManager
+ (instancetype)sharedManager {
    static O2MEventManager *sharedO2MEventManager = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedO2MEventManager = [[self alloc] init];
    });
    return sharedO2MEventManager;
}

-(instancetype) init; {
    if (self = [super init]) {
        _events = [[NSMutableArray alloc] init];
        _eventQueue = dispatch_queue_create("eventQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

-(void) addEvent :(NSDictionary*)event; {
    dispatch_async(self->_eventQueue,^{
        [self->_events addObject:event];
    });
}

@end
