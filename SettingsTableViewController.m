//
//  SettingsTableViewController.m
//  Constitution Trail Map
//
//  Created by Eddie Koranek on 8/6/14.
//  Copyright (c) 2014 Eddie Koranek. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "AppDelegate.h"

@interface SettingsTableViewController ()

@property (nonatomic, weak)IBOutlet UISlider *opacitySlider;
@property (nonatomic ,weak)IBOutlet UILabel *opacityLabel;
@property (nonatomic, weak)IBOutlet UISegmentedControl *opacitySelector;
@property (nonatomic, weak)IBOutlet UITableViewCell *standardTogOrd;
@property (nonatomic, weak)IBOutlet UITableViewCell *customTogOrd;
@property (nonatomic, weak)IBOutlet UITableViewCell *smartTogOrd;
@property (nonatomic, weak)IBOutlet UISegmentedControl *mapType;

@end

@implementation SettingsTableViewController
NSString *preferencesFile;
AppDelegate* appDelegate;
int opacity;

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    preferencesFile = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"Preferences"] stringByAppendingPathComponent:@"prefs.plist"];
    appDelegate = [UIApplication sharedApplication].delegate;
    
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    if ([fileManager fileExistsAtPath:preferencesFile]) {
        opacity = [[appDelegate preferenceForKey:@"OPACITY"]intValue];
        [_mapType setSelectedSegmentIndex:[[appDelegate preferenceForKey:@"MAP_TYPE"]intValue]];
    }else{
        [appDelegate setPreference:[NSNumber numberWithInt:70] forKey:@"OPACITY"];
        [appDelegate setPreference:[NSNumber numberWithInt:0] forKey:@"MAP_TYPE"];
        [_mapType setSelectedSegmentIndex:0];
        opacity = 70;
    }
    
    switch (opacity) {
        case 30:
            [_opacitySelector setSelectedSegmentIndex:0];
            _opacityLabel.text = [NSString stringWithFormat:@"%s %i%s", "UI Opacity:", 30, "%"];
            _opacitySlider.enabled = false;
            
            break;
            
        case 40:
            [_opacitySelector setSelectedSegmentIndex:1];
            _opacityLabel.text = [NSString stringWithFormat:@"%s %i%s", "UI Opacity:", 40, "%"];
            _opacitySlider.enabled = false;
            
            break;
            
        case 60:
            [_opacitySelector setSelectedSegmentIndex:2];
            _opacityLabel.text = [NSString stringWithFormat:@"%s %i%s", "UI Opacity:", 60, "%"];
            _opacitySlider.enabled = false;
            
            break;
            
        case 70:
            [_opacitySelector setSelectedSegmentIndex:3];
            _opacityLabel.text = [NSString stringWithFormat:@"%s %i%s", "UI Opacity:", 70, "%"];
            _opacitySlider.enabled = false;
            
            break;
            
        case 100:
            [_opacitySelector setSelectedSegmentIndex:4];
            _opacityLabel.text = [NSString stringWithFormat:@"%s %i%s", "UI Opacity:", 100, "%"];
            _opacitySlider.enabled = false;
            
            break;
            
        default:
            [_opacitySelector setSelectedSegmentIndex:5];
            _opacitySlider.value = opacity;
            
            _opacityLabel.text = [NSString stringWithFormat:@"%s %i%s", "UI Opacity:", opacity, "%"];
            _opacitySlider.enabled = true;
            
            break;
    }

}

- (void)viewWillAppear:(BOOL)animated{
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBOutlets

- (IBAction)changeMapType:(id)sender {
    if (_mapType.selectedSegmentIndex == 0) {
        [appDelegate setPreference:[NSNumber numberWithInt:0] forKey:@"MAP_TYPE"];
    }
    if (_mapType.selectedSegmentIndex == 1) {
        [appDelegate setPreference:[NSNumber numberWithInt:1] forKey:@"MAP_TYPE"];
    }
    if (_mapType.selectedSegmentIndex == 2) {
        [appDelegate setPreference:[NSNumber numberWithInt:2] forKey:@"MAP_TYPE"];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        return 3;
    }
    if (section == 2) {
        return 1;
    }else{
    return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_standardTogOrd.isSelected) {
        _standardTogOrd.accessoryType = UITableViewCellAccessoryCheckmark;
        _smartTogOrd.accessoryType = UITableViewCellAccessoryNone;
        _customTogOrd.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (_smartTogOrd.isSelected) {
        _standardTogOrd.accessoryType = UITableViewCellAccessoryNone;
        _smartTogOrd.accessoryType = UITableViewCellAccessoryCheckmark;
        _customTogOrd.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (_customTogOrd.isSelected) {
        _standardTogOrd.accessoryType = UITableViewCellAccessoryNone;
        _smartTogOrd.accessoryType = UITableViewCellAccessoryNone;
        _customTogOrd.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (IBAction)opacitySelectionChanged:(id)sender{
    switch (_opacitySelector.selectedSegmentIndex) {
        case 0:
            _opacityLabel.text = [NSString stringWithFormat:@"%s %i%s", "UI Opacity:", 30, "%"];
            [appDelegate setPreference:[NSNumber numberWithInt:30] forKey:@"OPACITY"];
            _opacitySlider.enabled = false;
            break;
            
        case 1:
            _opacityLabel.text = [NSString stringWithFormat:@"%s %i%s", "UI Opacity:", 40, "%"];
            [appDelegate setPreference:[NSNumber numberWithInt:40] forKey:@"OPACITY"];
            _opacitySlider.enabled = false;
            break;
            
        case 2:
            _opacityLabel.text = [NSString stringWithFormat:@"%s %i%s", "UI Opacity:", 60, "%"];
            [appDelegate setPreference:[NSNumber numberWithInt:60] forKey:@"OPACITY"];
            _opacitySlider.enabled = false;
            break;
            
        case 3:
            _opacityLabel.text = [NSString stringWithFormat:@"%s %i%s", "UI Opacity:", 70, "%"];
            [appDelegate setPreference:[NSNumber numberWithInt:70] forKey:@"OPACITY"];
            _opacitySlider.enabled = false;
            break;
            
        case 4:
            _opacityLabel.text = [NSString stringWithFormat:@"%s %i%s", "UI Opacity:", 100, "%"];
            [appDelegate setPreference:[NSNumber numberWithInt:100] forKey:@"OPACITY"];
            _opacitySlider.enabled = false;
            break;
            
        case 5:
            _opacityLabel.text = [NSString stringWithFormat:@"%s %i%s", "UI Opacity:", (int)_opacitySlider.value, "%"];
            [appDelegate setPreference:[NSNumber numberWithInt:(int)_opacitySlider.value] forKey:@"OPACITY"];
            _opacitySlider.enabled = true;
            break;
            
        default:
            break;
    }
}

- (IBAction)opacitySliderChange:(id)sender{
    _opacityLabel.text = [NSString stringWithFormat:@"%s %i%s", "UI Opacity:", (int)_opacitySlider.value, "%"];
    [appDelegate setPreference:[NSNumber numberWithInt:(int)_opacitySlider.value] forKey:@"OPACITY"];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
