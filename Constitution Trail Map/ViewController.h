//
//  ViewController.h
//  Constitution Trail Map
//
//  Created by Eddie Koranek on 6/30/14.
//  Copyright (c) 2014 Eddie Koranek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CustomTableViewCell.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak)IBOutlet CustomTableViewCell *customCell;

@end
