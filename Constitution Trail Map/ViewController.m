//
//  ViewController.m
//  Constitution Trail Map
//
//  Created by Eddie Koranek on 6/30/14.
//  Copyright (c) 2014 Eddie Koranek. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
#import "AppDelegate.h"
#import "UIImage+ImageCategory.h"

@interface ViewController () <UIGestureRecognizerDelegate> {
    
}

@property (nonatomic, weak)IBOutlet MKMapView *map; //Map centered on Bloomington Normal. Background of main ViewController
@property (nonatomic, weak)IBOutlet UITableView *toggleTable; //Table of Hexagon toggles. Right side of main ViewController
@property (nonatomic, weak)IBOutlet UIView *settingsView; //View with settings. Left side of main ViewController

@property (nonatomic, weak)IBOutlet UISwitch *solidColorToggle; //Set cell selected image opacity to 100% (non functioning)
@property (nonatomic, weak)IBOutlet UISwitch *locationToggle; //Show or hide user location (non functioning)

@property (nonatomic, weak)IBOutlet UIView *holdControls; //View contating showMenu & showSettings buttons. Simplifies animations
@property (nonatomic, weak)IBOutlet UIButton *showMenu; //alternative to edgeSwipe to show toggleTable
@property (nonatomic, weak)IBOutlet UIButton *showSettings;//alternative to edgeSwipe to show settingsView;

@property (nonatomic, strong)NSMutableArray *finalCoords; //sorted list of coords for long-lat reversal. REMOVE FOR FINAL BUILD
@property (nonatomic, strong)NSMutableArray *cords; //initial list of coors for long-lat reversal. REMOVE FOR FINAL BUILD

@property (nonatomic, weak)IBOutlet UIImageView *rightEdge;//imageView contating UIScreenEdgePanGestureRecognizer for toggleTable
@property (nonatomic, weak)IBOutlet UIImageView *leftEdge;//imageView contating UIScreenEdgePanGestureRecognizer for settingsView

@end

@implementation ViewController

NSString *preferencesFile; //file path to settings.plist
float opacity; //save opacity from plist to be assigned throughout main ViewController
AppDelegate* appDelegate;// uhhh... Johnny showed us this. I don't actually know what it does.
UIScreenEdgePanGestureRecognizer *leftEdgeSwipe; //UIScreenEdgePanGestureRecognizer used to bring settingsView onto screen
UIScreenEdgePanGestureRecognizer *rightEdgeSwipe; //UIScreenEdgePanGestureRecognizer used to bring toggleTable onto screen
UISwipeGestureRecognizer *toggleSwipe; //Swipe gesture to return toggleTable to off screen
UIPanGestureRecognizer *settingsPan; //Pan gesture to return settingVuew to off screen
UIColor *textColor; //default text color for tableViewCell when map type == default/standard
NSArray *defaultOrder; //contains string objects in order of default toggleTable list
CLLocationManager *locationManager; //needed to access user location from the OS

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _toggleTable.backgroundColor = [UIColor clearColor];

    [_map setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(40.49509, -88.989156), MKCoordinateSpanMake(.1, .1)) animated:YES];
    
    _finalCoords = [[NSMutableArray alloc]init];
    _cords = [[NSMutableArray alloc]init];
    
    preferencesFile = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"Preferences"] stringByAppendingPathComponent:@"prefs.plist"];
    appDelegate = [UIApplication sharedApplication].delegate;
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    leftEdgeSwipe = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeLeftEdge:)];
    [leftEdgeSwipe setEdges:UIRectEdgeLeft];
    [leftEdgeSwipe setDelegate:self];
    [_leftEdge addGestureRecognizer:leftEdgeSwipe];
    
    rightEdgeSwipe = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeRightEdge:)];
    [rightEdgeSwipe setEdges:UIRectEdgeRight];
    [rightEdgeSwipe setDelegate:self];
    [_rightEdge addGestureRecognizer:rightEdgeSwipe];
    
    settingsPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSettingsPan:)];
    [settingsPan setDelegate:self];
    [_settingsView addGestureRecognizer:settingsPan];
    
    toggleSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleToggleSwipe:)];
    [toggleSwipe setDelegate:self];
    [toggleSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [_toggleTable addGestureRecognizer:toggleSwipe];
    
    defaultOrder = [NSArray arrayWithObjects:@"repair", @"parking", @"restrooms", @"park", @"water", @"info", @"trash", @"bench", @"custom", nil];

#pragma mark - Polyline
    
//    NSArray *coordinates = [NSArray arrayWithObjects:@"-88.98623263719556",@"40.53174904583609",@"-88.98624136195663",@"40.53188349577464",@"-88.986271272078",@"40.53223158370165",@"-88.9862984412537",@"40.53257522665585",@"-88.98632609037243",@"40.5329219548626",@"-88.98635235582333",@"40.53324192826457",@"-88.98637028596816",@"40.53346759344704",@"-88.98639860373092",@"40.53381363158238",@"-88.98642301460242",@"40.5341277825274",@"-88.98646037654245",@"40.53452523600772",@"-88.986484413239",@"40.53482394905978",@"-88.98651434451543",@"40.53519708366104",@"-88.98654051367092",@"40.53553009561921",@"-88.98657124502883",@"40.5358929323342",@"-88.98660212160932",@"40.5362475335557",@"-88.98662924438057",@"40.53658602980074",@"-88.98665823775494",@"40.53690873238192",@"-88.98668842412381",@"40.53726162186955",@"-88.98671771143921",@"40.53761451641149",@"-88.98674528998035",@"40.53793036471421",nil];
//    NSString *lat;
//    NSString *lon;
//    for (int i = 0; i < coordinates.count; i++) {
//        if (i % 2 == 0) {
//            lon = [coordinates objectAtIndex:i];
//        }
//        if (i % 2 == 1) {
//            lat = [coordinates objectAtIndex:i];
//            
//            [_finalCoords addObject:lat];
//            [_finalCoords addObject:lon];
//        }
//    }
//    NSString *result = [_finalCoords componentsJoinedByString:@","];
//    NSLog(@"Done: %@", result);
//
//    float latitude = 0.0;
//    float longitude = 0.0;
//    
//    for (int i = 0; i < _finalCoords.count; i++) {
//        
//        if (i % 2 == 0) {
//            latitude = [[coordinates objectAtIndex:i]floatValue];
//        }
//        if (i % 2 == 1) {
//            longitude = [[coordinates objectAtIndex:i]floatValue];
//            
//            CLLocation *temp = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
//            [_cords addObject:temp];
//        }
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:preferencesFile]) {
        int opac = [[appDelegate preferenceForKey:@"OPACITY"]intValue];
        opacity = (float)opac/100.00;
        int mapType = [[appDelegate preferenceForKey:@"MAP_TYPE"]intValue];
        switch (mapType) {
            case 0:
                [_map setMapType:MKMapTypeStandard];
                textColor = [UIColor colorWithWhite:0.333 alpha:1.000];
                break;
                
            case 1:
                [_map setMapType:MKMapTypeHybrid];
                textColor = [UIColor whiteColor];
                break;
                
            case 2:
                [_map setMapType:MKMapTypeSatellite];
                textColor = [UIColor whiteColor];
                break;
                
            default:
                [_map setMapType:MKMapTypeStandard];
                textColor = [UIColor colorWithWhite:0.333 alpha:1.000];
                break;
        }
    }else{
        [appDelegate setPreference:[NSNumber numberWithInt:70] forKey:@"OPACITY"];
        opacity = 0.7;
        [appDelegate setPreference:[NSNumber numberWithInt:0] forKey:@"MAP_TYPE"];
    }
    
    [_toggleTable reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
}

- (void)viewWillDisappear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Touches


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *newtouch = [touches anyObject];
//    CGPoint newPoint = [newtouch locationInView:newtouch.window];
   // NSLog(@"Touch at %@",NSStringFromCGPoint(newPoint));
//
//    if (newtouch.view == _toggleTable) {
//        [UIView animateWithDuration:0.3 animations:^{
//            CGRect frame = _toggleTable.frame;
//            frame.origin.x = newPoint.x;
//            _toggleTable.frame = frame;
//        }];
//    }
//}
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

//returns number of rows for toggleTable
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return defaultOrder.count;
}

//creates and populates custom cells in toggleTable with title, graphic, and selected background image.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
        if(!cell){
            [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
            cell = _customCell;
            _customCell = nil;
            }
    NSString *title = [defaultOrder objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        cell.cellLabel.text = title;//@"water";
        cell.cellLabel.textColor = textColor;
        cell.cellImage.image = [UIImage imageNamed: [NSString stringWithFormat:@"%@.png",title]];
        UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        UIImage *backgroundImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@SelectSolid.png",title]];
        backgroundView.clipsToBounds = YES;
        backgroundView.image = [backgroundImage imageByApplyingAlpha:opacity];
        
        cell.selectedBackgroundView = backgroundView;
        [cell.selectedBackgroundView setAlpha:opacity];
        cell.clipsToBounds = YES;
        
        return cell;
}

//returns height for rows in toggleTable. All rows are 100 points high
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark - IBActions

//alternative method to display toggleTable and hide settingsView if necessary
- (IBAction)showToggles{
    int origin;
    int buttonOrigin = 5;
    int settings = -320;
    UIColor *buttonColor;
    
    if (_toggleTable.frame.origin.x > 0) {
        origin = 0;
        buttonColor = nil;
    }else{
        origin = 320;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _toggleTable.frame;
        frame.origin.x = origin;
        _toggleTable.frame = frame;
        CGRect btnFrmO = _showMenu.frame;
        btnFrmO.origin.x = buttonOrigin;
        _showMenu.frame = btnFrmO;
        CGRect btnFrm1 = _showSettings.frame;
        btnFrm1.origin.x = buttonOrigin;
        _showSettings.frame = btnFrm1;
        CGRect togFrame = _settingsView.frame;
        togFrame.origin.x = settings;
        _settingsView.frame = togFrame;
        _showSettings.tintColor = buttonColor;
        _showMenu.tintColor = buttonColor;

    }];
}

//alternative method to display settingsView and hide toggleTable if necessary
- (IBAction)showSettingsView{
    int origin;
    int buttonOrigin;
    int toggleTable = 320;
    UIColor *buttonColor;
    
    if (_settingsView.frame.origin.x < 0) {
        origin = 0;
        buttonOrigin = 270;
        buttonColor = [UIColor whiteColor];
    }else{
        origin = -320;
        buttonOrigin = 5;
        buttonColor = nil;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _settingsView.frame;
        frame.origin.x = origin;
        _settingsView.frame = frame;
        CGRect btnFrmO = _showMenu.frame;
        btnFrmO.origin.x = buttonOrigin;
        _showMenu.frame = btnFrmO;
        CGRect btnFrm1 = _showSettings.frame;
        btnFrm1.origin.x = buttonOrigin;
        _showSettings.frame = btnFrm1;
        CGRect togFrame = _toggleTable.frame;
        togFrame.origin.x = toggleTable;
        _toggleTable.frame = togFrame;
        _showSettings.tintColor = buttonColor;
        _showMenu.tintColor = buttonColor;
    }];
}

- (IBAction)toggleUserLocation:(id)sender{
    if (_locationToggle.isOn) {
        [locationManager startUpdatingLocation];
        _map.showsUserLocation = YES;
    }if (!_locationToggle.isOn) {
        [locationManager stopUpdatingLocation];
        _map.showsUserLocation = NO;
    }
}

- (IBAction)toggleSolidGraphics{
    
}

//returns map to default zoom and region.
- (IBAction)setMapHome:(id)sender {
    [_map setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(40.49509, -88.989156), MKCoordinateSpanMake(.1, .1)) animated:YES];
}

#pragma mark - Gesture Handling

//handling for UIScreenEdgePanGestureRecognizer on leftEdge image view. Allows user to "pull" settingsView onto screen. Animates settingsView to corrent location at end of gesture.
- (void)handleSwipeLeftEdge:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer{
  //  NSLog(@"Swiped!");
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    CGRect frame = _settingsView.frame;
    frame.origin = CGPointMake(frame.origin.x + translation.x, 0);
    _settingsView.frame = frame;
    [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = _settingsView.frame;
            frame.origin.x = 0;
            _settingsView.frame= frame;
        }];
    }
   // NSLog(@"X: %f, Y: %f)", translation.x, translation.y);
    
}

//handling for UIScreenEdgePanGestureRecognizer on rightEdge image view. Allows user to "pull" toggleTable onto screen. Animates toggleTable to corrent location at end of gesture.
- (void)handleSwipeRightEdge:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer{
   // NSLog(@"Swiped!");
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    CGRect frame = _toggleTable.frame;
    frame.origin = CGPointMake(frame.origin.x + translation.x, 0);
    _toggleTable.frame = frame;
    [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];

    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = _toggleTable.frame;
            frame.origin.x = 0;
            _toggleTable.frame= frame;
        }];
    }
  //  NSLog(@"X: %f, Y: %f)", translation.x, translation.y);
}

//handling for pan gesture on settingsView. Allows settingsView to move with users touch, then animates off screen to the proper location when gesture ends.
- (void)handleSettingsPan:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    _settingsView.center = CGPointMake(gestureRecognizer.view.center.x + translation.x,
                                        gestureRecognizer.view.center.y);
    [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = _settingsView.frame;
            frame.origin.x = -320;
            _settingsView.frame = frame;
        }];
    }
}

//handling for swipe gesture on toggleTable. Hides toggle table on swipe to right then animates to proper off screen location.
- (void)handleToggleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = _toggleTable.frame;
            frame.origin.x = 320;
            _toggleTable.frame = frame;
        }];
    }
}

@end
