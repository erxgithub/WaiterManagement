//
//  Shift.h
//  StaffManagement
//
//  Created by Eric Gregor on 2018-03-30.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Waiter;

@interface Shift : NSManagedObject

@property (nonatomic, retain) Waiter *waiter;
@property (nonatomic, retain) NSDate *startTime;
@property (nonatomic, retain) NSDate *finishTime;

@end
