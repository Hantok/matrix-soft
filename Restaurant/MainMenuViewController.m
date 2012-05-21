//
//  MainMenuViewController.m
//  Restaurant
//
//  Created by Bogdan Geleta on 24.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewController.h"
#import "MenuListTableViewController.h"
#import "CartCell.h"
#import "Offers.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController
@synthesize pickerView = _pickerView;
@synthesize menuButton = _menuButton;
@synthesize cartButton = _cartButton;
@synthesize settingsButton = _settingsButton;
@synthesize restorantsButton = _restorantsButton;
@synthesize arrayData = _arrayData;
@synthesize selectedRow = _selectedRow;
@synthesize isCartMode = _isCartMode;
@synthesize isMenuMode = _isMenuMode;
@synthesize tableView = _tableView;
@synthesize tableViewController = _tableViewController;
@synthesize delegatepV = _delegatepV;
@synthesize dataSourcepV = _dataSourcepV;
@synthesize db = _db;

- (void)setDb:(XMLParse *)db
{
    _db = db;
}


- (IBAction)menuButton:(id)sender {
    self.isMenuMode = YES;
    self.isCartMode = NO;
    self.menuButton.enabled = NO;
    self.cartButton.enabled = YES;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerTapped:)];
    [self.pickerView addGestureRecognizer:tapgesture];
}
- (IBAction)cartButton:(id)sender {
    self.isCartMode = YES;
    self.isMenuMode = NO;
    self.menuButton.enabled = YES;
    self.cartButton.enabled = NO;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.pickerView removeGestureRecognizer:[self.pickerView.gestureRecognizers lastObject]];
}
- (IBAction)goToSettingsTableViewController:(id)sender {
    [self performSegueWithIdentifier:@"toSettings" sender:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self menuButton:self];
    
    
    NSMutableArray *arrayData = [[NSMutableArray alloc] init];
    [arrayData addObject:@"Some stuff"];
    [arrayData addObject:@"Some stuff"];
    [arrayData addObject:@"Pizza"];
    [arrayData addObject:@"Some stuff"];
    [arrayData addObject:@"Some stuff"];
    [arrayData addObject:@"Some stuff"];
    [arrayData addObject:@"Some stuff"];
    self.arrayData = arrayData;
    self.isMenuMode = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.pickerView selectRow:1 inComponent:0 animated:YES];
}

- (void)viewDidUnload
{
    [self setPickerView:nil];
    [self setMenuButton:nil];
    [self setCartButton:nil];
    [self setSettingsButton:nil];
    [self setRestorantsButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma pickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(self.isMenuMode)
    {
        return self.arrayData.count;
    }
    else 
    {
        return 1;
    };
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if(self.isCartMode)
    {   
        self.tableView = [[UITableView alloc] init];//WithFrame:CGRectMake(0, 0, 100, 216)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        return self.tableView;
        //[[[[NSUserDefaults standardUserDefaults] objectForKey:@"offers"] objectAtIndex:row] objectForKey:@"id"];
        
    }
    else {
        UIView *viewForRow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.pickerView.frame.size.width-30, self.pickerView.frame.size.height/5)];
        //NSLog(@"%f", viewForRow.frame.size.width);
        //NSLog(@"%f", viewForRow.frame.size.height);
        UIImage *imageForUIImageView  = [UIImage imageNamed:@"files.iphone.shop.category7.jpg"];
        UIImageView *imageViewForViewForRow = [[UIImageView alloc] initWithImage:imageForUIImageView];
        UILabel *labelForRow = [[UILabel alloc] initWithFrame:CGRectMake(imageViewForViewForRow.frame.size.width, 5, self.pickerView.frame.size.width-30, pickerView.frame.size.height/5)];
        labelForRow.text = [self.arrayData objectAtIndex:row];
        [viewForRow addSubview:imageViewForViewForRow];
        [viewForRow addSubview:labelForRow];
        
        return viewForRow;
    }
}

-(void)pickerTapped:(UIGestureRecognizer *)gestureRecognizer {
    //определяем координату куда нажали на UIPickerView
    CGPoint myP = [gestureRecognizer locationInView:self.pickerView];
    //Определяем высоту строки в UIPickerView. Я делю на 5 потому что использую стандартную высотку строки
    CGFloat heightOfPickerRow = self.pickerView.frame.size.height/3;
    //объявляем переменную для хранения информации про строку
    NSInteger rowToSelect =[self.pickerView selectedRowInComponent:0];
    //Analyse if any action on the tap is required
    if (myP.y<heightOfPickerRow) {
        //selected area corresponds to current_row-2 row
        //check if we can move to that row (i.e. that
        //it exists and is not blank
        if ([self.pickerView selectedRowInComponent:0] > 0)
            rowToSelect -=1;
        else
            rowToSelect = -1; //no action required code
    }
    else if (myP.y<2*heightOfPickerRow) {
        //selected area corresponds to current_row-1 row
        //check if we can move to that row (i.e. that
        //it exists and is not blank
        rowToSelect = [self.pickerView selectedRowInComponent:0];
    }
    else if (myP.y<3*heightOfPickerRow) {
        //selected area corresponds to current_row+1 row
        //check if we can move to that row (i.e. that
        //it exists and is not blank
        if ([self.pickerView selectedRowInComponent:0] <
            ([self.pickerView numberOfRowsInComponent:0]-1))
            rowToSelect +=1;
        else
            rowToSelect = -1; //no action required code
    }
    else if (myP.y<4*heightOfPickerRow) {
        //selected area corresponds to current_row+1 row
        //check if we can move to that row (i.e. that
        //it exists and is not blank
        if ([self.pickerView selectedRowInComponent:0] <
            ([self.pickerView numberOfRowsInComponent:0]-1))
            rowToSelect +=1;
        else
            rowToSelect = -1; //no action required code
    }
    else {
        //selected area corresponds to current_row+2 row
        //check if we can move to that row (i.e. that
        //it exists and is not blank
        if ([self.pickerView selectedRowInComponent:0] <
            ([self.pickerView numberOfRowsInComponent:0]-2))
            rowToSelect += 2;
        else
            rowToSelect = -1; //no action required code
    }
    //check that we do need to process the tap
    if (rowToSelect!=-1) {
        //tell picker view to scroll to required row
        //ATTENTION - didSelectRow method is not called when you
        //tell the picker to move to select some row
        [self.pickerView selectRow:rowToSelect inComponent:0 animated:YES];
        //hence we need another function
        [self customPickerView:self.pickerView didSelectRow:rowToSelect inComponent:0
                 asResultOfTap:YES];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self customPickerView:pickerView didSelectRow:row inComponent:component asResultOfTap:NO];
}

- (void)customPickerView:(UIPickerView *)pickerView 
            didSelectRow:(NSInteger)row
             inComponent:(NSInteger)component 
           asResultOfTap:(bool)userTapped
{
    if (userTapped) 
    {
        NSNumber *selectedRow = [[NSNumber alloc] initWithInt:row];
        //NSLog(@"tapped in %i", row);
        self.selectedRow = selectedRow;
        if(self.isMenuMode)
            [self performSegueWithIdentifier:@"menuList" sender:self];
        //[self performSegueWithIdentifier:@"somewhere" sender:self];
    }
    else 
    {
        //NSLog(@"selected row %i", row);
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if(self.isCartMode)
        return self.pickerView.frame.size.height;
    else return self.pickerView.frame.size.height/4;
}

#pragma segue Delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"%@",[self.arrayData objectAtIndex:self.selectedRow.integerValue]);
    if ([segue.identifier isEqualToString:@"menuList"])
    {
        [segue.destinationViewController setKindOfMenu:[self.arrayData objectAtIndex:self.selectedRow.integerValue]];
    }
    
}


#pragma tableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 20;
    Offers* offers = [[Offers alloc] init];
    //NSLog(@"%i", count);
    return offers.offers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    NSString *CellIdentifier = @"CellData";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellAccessoryDisclosureIndicator reuseIdentifier:CellIdentifier];
    }
    //NSString *row = [[NSString alloc] initWithFormat:@"%i", indexPath.row];
    //cell.textLabel.text = row;
    NSArray *offers = [[[NSUserDefaults standardUserDefaults] objectForKey:@"offers"] allValues];
    NSString *productId = [[offers objectAtIndex:indexPath.row] objectForKey:@"id"];
    NSString *productCount = [[offers objectAtIndex:indexPath.row] objectForKey:@"count"];
    
    
    
    
    return cell;
    
  */  
    
    
    NSString *CellIdentifier = @"CartCell";
    CartCell *cell = (CartCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CartCell" owner:nil options:nil];
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[CartCell class]])
            {
                cell = (CartCell *)currentObject;
                break;
            }
        }
    }
    
    Offers* offers = [[Offers alloc] init];
    
    cell.productTitle.text = [NSString stringWithFormat:@"%@", [[offers.offers objectAtIndex:indexPath.row] objectForKey:@"name"]];
    NSNumber *count = [[NSNumber alloc] initWithInteger:[[[offers.offers objectAtIndex:indexPath.row] objectForKey:@"count"] intValue]];

    cell.productCount.text = [NSString stringWithFormat:@"%i шт.", [count intValue]];
    NSNumber *cost = [[NSNumber alloc] initWithInteger:[[[offers.offers objectAtIndex:indexPath.row] objectForKey:@"cost"] intValue]];
    cell.productPrice.text = [NSString stringWithFormat:@"%i грн.", [cost intValue]*[count intValue]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%i", indexPath.row);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Offers* offers = [[Offers alloc] init];
        [offers removeOffer:[offers.offers objectAtIndex:indexPath.row]];
        [self.tableView reloadData];
        ////NSLog(@"Hello from delete!");
        }  
}

@end