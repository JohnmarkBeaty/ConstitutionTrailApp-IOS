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
#import "BenchCellPhone.h"
#import "AddCellPhone.h"

@interface ViewController () <UIGestureRecognizerDelegate> {
    
}

@property (nonatomic, weak)IBOutlet UITableView *toggleTable;
@property (nonatomic, weak)IBOutlet MKMapView *map;
@property (nonatomic, weak)IBOutlet UIButton *showMenu;
@property (nonatomic, strong)NSMutableArray *finalCoords;
@property (nonatomic, strong)NSMutableArray *cords;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    _toggleTable.backgroundColor = [UIColor clearColor];
    
    [_map setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(40.49509, -88.989156), MKCoordinateSpanMake(.1, .1)) animated:YES];
    
    _finalCoords = [[NSMutableArray alloc]init];
    _cords = [[NSMutableArray alloc]init];

#pragma mark - Polyline
    
    NSArray *coordinates = [NSArray arrayWithObjects:@"-88.94470804855509",@"40.55710594190552",@"-88.94467558723221",@"40.55620785360567",@"-88.94467525721058",@"40.55572647298415",@"-88.94467413374777",@"40.55560295956953",@"-88.94477433781123",@"40.55475014563741",@"-88.94479453725155",@"40.55454760419092",@"-88.94481311177151",@"40.55441369321569",@"-88.94482550087557",@"40.55434157466716",@"-88.94489159034727",@"40.55411511574143",@"-88.94492165930264",@"40.55405800040545",@"-88.94496946450799",@"40.55399736007074",@"-88.94503261001071",@"40.55394178513676",@"-88.94508707779562",@"40.55389654940085",@"-88.94512626447065",@"40.55385276699814",@"-88.94515436830602",@"40.55380218108512",@"-88.94516697242803",@"40.55375373590606",@"-88.94517096770672",@"40.5536984741277",@"-88.9451682470859",@"40.5536466790095",@"-88.94516134386109",@"40.55360485621496",@"-88.94514114008878",@"40.55355967275994",@"-88.94505008258291",@"40.55343972350697",@"-88.94473249102282",@"40.55304271144015",@"-88.94468576198585",@"40.55297433682422",@"-88.94465008442994",@"40.55290933480705",@"-88.94462551760087",@"40.55285422416616",@"-88.9446140106899",@"40.55280075996769",@"-88.94460415688035",@"40.55268175310549",@"-88.94458324353063",@"40.55159386340057",@"-88.94456205182252",@"40.55143991931708",@"-88.94455910092837",@"40.55136273527229",@"-88.94456295932355",@"40.55129237739381",@"-88.94457356743698",@"40.55124703080492",@"-88.94459077551521",@"40.55121022703605",@"-88.94461687619203",@"40.55118675748854",@"-88.94465180707101",@"40.55116976029481",@"-88.9447394103606",@"40.55115763100248",@"-88.94520672516617",@"40.55112839446501",@"-88.94667194975497",@"40.55102524077083",@"-88.94762403865357",@"40.55095807960755",@"-88.94822051147227",@"40.55091133170912",@"-88.9482885635923",@"40.55090101932733",@"-88.94834983745791",@"40.5508873118925",@"-88.9484110642091",@"40.55086845803231",@"-88.9485204140654",@"40.550824300907",@"-88.94866043926692",@"40.55076522659459",@"-88.95012474466003",@"40.55009761874927",@"-88.95020136494776",@"40.55006530048429",@"-88.95028013513654",@"40.55004669507231",@"-88.95037870835736",@"40.55002935628251",@"-88.95049713499697",@"40.55001877354878",@"-88.95064646313215",@"40.55001797576562",@"-88.95083527022894",@"40.55003034806497",@"-88.95116073076518",@"40.55008213319367",@"-88.95129247548404",@"40.55010132895909",@"-88.95202676329569",@"40.55022126168152",@"-88.95365749771743",@"40.55046058566076",@"-88.95375634928871",@"40.55047343613624",@"-88.95383531528813",@"40.55047610004282",@"-88.95397137564892",@"40.55047536921701",@"-88.95458301770775",@"40.55039179427077",@"-88.95528205521769",@"40.55027412091312",@"-88.95541126940934",@"40.55023842807347",@"-88.95553804718182",@"40.55018250474754",@"-88.95561443307309",@"40.55012513716321",@"-88.95568624476815",@"40.55005955953897",@"-88.95576212595306",@"40.54997200093424",@"-88.95584185346102",@"40.54981408409432",@"-88.95654193772953",@"40.54837885660514",@"-88.95717357843142",@"40.54715672218588",@"-88.95975027452791",@"40.54714278045934",@"-88.96184835302297",@"40.54714819831322",@"-88.96326415334434",@"40.54715867247864", nil];
    NSString *lat;
    NSString *lon;
    for (int i = 0; i < coordinates.count; i++) {
        if (i % 2 == 0) {
            lon = [coordinates objectAtIndex:i];
        }
        if (i % 2 == 1) {
            lat = [coordinates objectAtIndex:i];
            
            [_finalCoords addObject:lat];
            [_finalCoords addObject:lon];
        }
    }
    NSString *result = [_finalCoords componentsJoinedByString:@","];
    NSLog(@"Done: %@", result);

    float latitude = 0.0;
    float longitude = 0.0;
    
    for (int i = 0; i < _finalCoords.count; i++) {
        
        if (i % 2 == 0) {
            latitude = [[coordinates objectAtIndex:i]floatValue];
        }
        if (i % 2 == 1) {
            longitude = [[coordinates objectAtIndex:i]floatValue];
            
            CLLocation *temp = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
            [_cords addObject:temp];
        }
    }
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
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        UITableViewCell *cell = (WaterCellPhone *)[tableView dequeueReusableCellWithIdentifier:@"WaterCellPhone"];
        if (!cell) {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"WaterCellPhone" owner:self options:nil];
            cell = [cells objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        UIImage *backgroundImage = [UIImage imageNamed:@"WaterSelectTransparent.png"];
        backgroundView.image = backgroundImage;
        
        cell.selectedBackgroundView = backgroundView;

        return cell;
    }
    if (indexPath.row == 1) {
        UITableViewCell *cell = (ParkingCellPhone *)[tableView dequeueReusableCellWithIdentifier:@"ParkingCellPhone"];
        if (!cell) {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"ParkingCellPhone" owner:self options:nil];
            cell = [cells objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        UIImage *backgroundImage = [UIImage imageNamed:@"ParkingSelectTransparent.png"];
        backgroundView.image = backgroundImage;
        
        cell.selectedBackgroundView = backgroundView;
        
        return cell;
    }
    if (indexPath.row == 0) {
        UITableViewCell *cell = (RepairCellPhone *)[tableView dequeueReusableCellWithIdentifier:@"RepairCellPhone"];
        if (!cell) {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"RepairCellPhone" owner:self options:nil];
            cell = [cells objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        UIImage *backgroundImage = [UIImage imageNamed:@"RepairSelectTransparent.png"];
        backgroundView.image = backgroundImage;
        
        cell.selectedBackgroundView = backgroundView;
        
        return cell;
    }
    if (indexPath.row == 2) {
        UITableViewCell *cell = (ShopsCellPhone *)[tableView dequeueReusableCellWithIdentifier:@"ShopsCellPhone"];
        if (!cell) {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"ShopsCellPhone" owner:self options:nil];
            cell = [cells objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        UIImage *backgroundImage = [UIImage imageNamed:@"ShopSelectTransparent.png"];
        backgroundView.image = backgroundImage;
        
        cell.selectedBackgroundView = backgroundView;
        
        return cell;
    }
    if (indexPath.row == 3) {
        UITableViewCell *cell = (ParkCellPhone *)[tableView dequeueReusableCellWithIdentifier:@"ParkCellPhone"];
        if (!cell) {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"ParkCellPhone" owner:self options:nil];
            cell = [cells objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        UIImage *backgroundImage = [UIImage imageNamed:@"ParkSelectTransparent.png"];
        backgroundView.image = backgroundImage;
        
        cell.selectedBackgroundView = backgroundView;
        
        return cell;
    }
    if (indexPath.row == 5) {
        UITableViewCell *cell = (OtherCellPhone *)[tableView dequeueReusableCellWithIdentifier:@"OtherCellPhone"];
        if (!cell) {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"OtherCellPhone" owner:self options:nil];
            cell = [cells objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        UIImage *backgroundImage = [UIImage imageNamed:@"InfoSelectTransparent.png"];
        backgroundView.image = backgroundImage;
        
        cell.selectedBackgroundView = backgroundView;
        
        return cell;
    }
    if (indexPath.row == 6) {
        UITableViewCell *cell = (BenchCellPhone *)[tableView dequeueReusableCellWithIdentifier:@"BenchCellPhone"];
        if (!cell) {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"BenchCellPhone" owner:self options:nil];
            cell = [cells objectAtIndex:0];
            
            UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
            UIImage *backgroundImage = [UIImage imageNamed:@"BenchSelectTransparent.png"];
            backgroundView.image = backgroundImage;
            
            cell.selectedBackgroundView = backgroundView;
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else{
        UITableViewCell *cell = (AddCellPhone *)[tableView dequeueReusableCellWithIdentifier:@"AddCellPhone"];
        if (!cell) {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"AddCellPhone" owner:self options:nil];
            cell = [cells objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        UIImage *backgroundImage = [UIImage imageNamed:@"AddSelectTransparent.png"];
        backgroundView.image = backgroundImage;
        
        cell.selectedBackgroundView = backgroundView;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark - IBActions

- (IBAction)showToggles{
    int origin;
    
    if (_toggleTable.frame.origin.x > 0) {
        origin = 0;
    }else{
        origin = 320;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _toggleTable.frame;
        frame.origin.x = origin;
        _toggleTable.frame = frame;
    }];
}

@end
