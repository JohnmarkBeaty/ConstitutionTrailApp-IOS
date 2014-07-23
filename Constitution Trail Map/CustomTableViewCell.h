//
//  CustomTableViewCell.h
//  Constitution Trail Map
//
//  Created by Eddie Koranek on 7/23/14.
//  Copyright (c) 2014 Eddie Koranek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UILabel *cellLabel;
@property (nonatomic, weak)IBOutlet UIImageView *cellImage;

@end
