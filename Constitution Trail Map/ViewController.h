//
//  ViewController.h
//  Constitution Trail Map
//
//  Created by Eddie Koranek on 6/30/14.
//  Copyright (c) 2014 Eddie Koranek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak)IBOutlet UITableViewCell *waterCell;
@property (nonatomic, weak)IBOutlet UITableViewCell *parkingCell;
@property (nonatomic, weak)IBOutlet UITableViewCell *repairCell;
@property (nonatomic, weak)IBOutlet UITableViewCell *shopsCell;
@property (nonatomic, weak)IBOutlet UITableViewCell *parkCell;
@property (nonatomic, weak)IBOutlet UITableViewCell *otherCell;

@end
