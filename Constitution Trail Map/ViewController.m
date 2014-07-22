//
//  ViewController.m
//  Constitution Trail Map
//
//  Created by Eddie Koranek on 6/30/14.
//  Copyright (c) 2014 Eddie Koranek. All rights reserved.
//

#import "ViewController.h"
#import "WaterCellPhone.h"
#import "ParkingCellPhone.h"
#import "RepairCellPhone.h"
#import "ShopsCellPhone.h"
#import "ParkCellPhone.h"
#import "OtherCellPhone.h"

@interface ViewController () <UIGestureRecognizerDelegate> {
    
}

@property (nonatomic, weak)IBOutlet UITableView *toggleTable;
@property (nonatomic, weak)IBOutlet MKMapView *map;
@property (nonatomic, weak)IBOutlet UIButton *showMenu;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    _toggleTable.backgroundColor = [UIColor clearColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Touches


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *newtouch = [touches anyObject];
    CGPoint newPoint = [newtouch locationInView:newtouch.window];
    NSLog(@"Touch at %@",NSStringFromCGPoint(newPoint));
//
//    if (newtouch.view == _toggleTable) {
//        [UIView animateWithDuration:0.3 animations:^{
//            CGRect frame = _toggleTable.frame;
//            frame.origin.x = newPoint.x;
//            _toggleTable.frame = frame;
//        }];
//    }
}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *newtouch = [touches anyObject];
//    CGPoint newPoint = [newtouch locationInView:newtouch.window];
//    NSLog(@"Touch at %@",NSStringFromCGPoint(newPoint));
//    
//    if (newtouch.view == _toggleTable) {
//        CGRect frame = _toggleTable.frame;
//        frame.origin.x = newPoint.x;
//        _toggleTable.frame = frame;
//    }
//}

#pragma mark - Tableview Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = (WaterCellPhone *)[tableView dequeueReusableCellWithIdentifier:@"WaterCellPhone"];
        if (!cell) {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"WaterCellPhone" owner:self options:nil];
            cell = [cells objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    if (indexPath.row == 1) {
        UITableViewCell *cell = (ParkingCellPhone *)[tableView dequeueReusableCellWithIdentifier:@"ParkingCellPhone"];
        if (!cell) {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"ParkingCellPhone" owner:self options:nil];
            cell = [cells objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    if (indexPath.row == 2) {
        UITableViewCell *cell = (RepairCellPhone *)[tableView dequeueReusableCellWithIdentifier:@"RepairCellPhone"];
        if (!cell) {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"RepairCellPhone" owner:self options:nil];
            cell = [cells objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    if (indexPath.row == 3) {
        UITableViewCell *cell = (ShopsCellPhone *)[tableView dequeueReusableCellWithIdentifier:@"ShopsCellPhone"];
        if (!cell) {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"ShopsCellPhone" owner:self options:nil];
            cell = [cells objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    if (indexPath.row == 4) {
        UITableViewCell *cell = (ParkCellPhone *)[tableView dequeueReusableCellWithIdentifier:@"ParkCellPhone"];
        if (!cell) {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"ParkCellPhone" owner:self options:nil];
            cell = [cells objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else{
        UITableViewCell *cell = (OtherCellPhone *)[tableView dequeueReusableCellWithIdentifier:@"OtherCellPhone"];
        if (!cell) {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"OtherCellPhone" owner:self options:nil];
            cell = [cells objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark - IBActions

- (IBAction)showToggles{
    BOOL skip = YES;
    if (_toggleTable.frame.origin.x > 0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = _toggleTable.frame;
            frame.origin.x = 0;
            _toggleTable.frame = frame;
        }];
        skip = NO;
        [_showMenu setTitle:@"Hide" forState:UIControlStateNormal];
    }
    
    if (_toggleTable.frame.origin.x == 0 && skip) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = _toggleTable.frame;
            frame.origin.x = 320;
            _toggleTable.frame = frame;
        }];
        [_showMenu setTitle:@"Show" forState:UIControlStateNormal];
    }
    skip = YES;

}

@end
