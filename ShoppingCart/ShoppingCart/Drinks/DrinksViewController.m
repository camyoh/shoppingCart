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

@interface DrinksViewController ()

@end

@implementation DrinksViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    DrinksViewModel *drinksViewModel = [[DrinksViewModel alloc] init];
    [drinksViewModel createDrinks];
    NSMutableArray<DrinkModel *> *drinks = [drinksViewModel drinks];
    DrinkModel *drink = [drinks objectAtIndex:3];
    NSLog(@"%@", drink.name);
    NSLog(@"datos");
}

@end
