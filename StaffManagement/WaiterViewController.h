//
//  WaiterViewController.h
//  StaffManagement
//
//  Created by Eric Gregor on 2018-03-30.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaiterProtocol <NSObject>

- (void)addNewWaiter:(NSString *)name;

@end

@interface WaiterViewController : UIViewController

@property (weak, nonatomic) id <WaiterProtocol> delegate;

@end
