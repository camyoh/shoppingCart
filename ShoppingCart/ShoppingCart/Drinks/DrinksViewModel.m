//
//  DrinksViewModel.m
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/6/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "DrinksViewModel.h"
#import "DrinkModel.h"
#import "RequestModel.h"

@implementation DrinksViewModel

- (void)createDrinks {
    RequestModel *requestModel = [[RequestModel alloc] init];
    self.drinks = [NSMutableArray new];
    NSDictionary *drinksData = [requestModel getDataFromJson];
    NSUInteger totalDrinks = [drinksData[@"data"] count];
    for (int i = 0; i < totalDrinks; i++)
    {
        DrinkModel *drink = [[DrinkModel alloc] init];
        drink.name = drinksData[@"data"][i][@"name"];
        drink.image = drinksData[@"data"][i][@"image"];
        drink.price = drinksData[@"data"][i][@"store"][@"price"];
        [self.drinks addObject:drink];
    }
//    NSLog(@"total bebidas: %lu",(unsigned long)totalDrinks);
}

@end
