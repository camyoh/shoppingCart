//
//  DrinksViewController.m
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/2/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "DrinksViewController.h"
#import "DrinksViewModel.h"
#import "DrinkModel.h"

@interface DrinksViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *drinksTableView;

@end

@implementation DrinksViewController

int numberOfRowx = 0;
NSMutableArray<DrinkModel *> *drinks;

- (void)viewDidLoad {
    [super viewDidLoad];
    DrinksViewModel *drinksViewModel = [[DrinksViewModel alloc] init];
    [drinksViewModel createDrinks];
    drinks = [drinksViewModel drinks];
    DrinkModel *drink = [drinks objectAtIndex:3];
    numberOfRowx = (int)[drinks count];
    NSLog(@"%@",[drinks objectAtIndex:0].name);
    NSLog(@"%lu", (unsigned long)[drinks count]);
    NSLog(@"%@", drink.name);
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    static NSString *cellId = @"drinkCell";
    DrinkCell *cell = (DrinkCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DrinkCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSString *imageUrl = [drinks objectAtIndex:indexPath.row].image;
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:imageUrl]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.drinkImage.image = [UIImage imageWithData: data];
        });
//        [data release];
    });
    
    cell.drinkTitle.text = [drinks objectAtIndex:indexPath.row].name;
    NSString *drinkPrice = @"$ ";
    cell.drinkPrice.text = [drinkPrice stringByAppendingString: [[drinks objectAtIndex:indexPath.row].price stringValue]] ;
    NSLog(@"%ld", (long)indexPath.row);
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numberOfRowx;
}


@end
