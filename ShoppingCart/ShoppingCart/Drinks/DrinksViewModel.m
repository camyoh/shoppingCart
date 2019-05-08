//
//  DrinksViewModel.m
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/6/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "DrinksViewModel.h"
//#import "DrinkModel.h"
#import "RequestModel.h"
#import "ShoppingCartViewModel.h"

@implementation DrinksViewModel
@synthesize delegate; //synthesise  MyClassDelegate delegate

RequestModel *requestModel;
ShoppingCartViewModel *shoppingCartViewModel;

- (void)createDrinks {
    shoppingCartViewModel = [[ShoppingCartViewModel alloc] init];
    NSString *defaultUrl = @"http://applicorera3jjjs.com/api/mobile/categories/14/products?page=1";
    requestModel = [[RequestModel alloc] init];
    self.drinks = [NSMutableArray new];
    NSDictionary *drinksData = [requestModel getDataFromJson:defaultUrl];
    NSUInteger totalDrinks = [drinksData[@"data"] count];
    for (int i = 0; i < totalDrinks; i++)
    {
        DrinkModel *drink = [[DrinkModel alloc] init];
        drink.name = drinksData[@"data"][i][@"name"];
        drink.image = drinksData[@"data"][i][@"image"];
        drink.price = drinksData[@"data"][i][@"store"][@"price"];
        if (drinksData[@"next_page_url"] == (id)[NSNull null]) {
            drink.nextPage = @"null";
        }
        else {
            drink.nextPage = drinksData[@"next_page_url"];
        }
        [self.drinks addObject:drink];
    }
//    NSLog(@"total bebidas: %lu",(unsigned long)totalDrinks);
}

-(void)requestNextPage:(NSString *)url {
    requestModel = [[RequestModel alloc] init];
    self.drinks = [NSMutableArray new];
    NSDictionary *drinksData = [requestModel getDataFromJson:url];
    NSUInteger totalDrinks = [drinksData[@"data"] count];
    for (int i = 0; i < totalDrinks; i++)
    {
        DrinkModel *drink = [[DrinkModel alloc] init];
        drink.name = drinksData[@"data"][i][@"name"];
        drink.image = drinksData[@"data"][i][@"image"];
        drink.price = drinksData[@"data"][i][@"store"][@"price"];
        if (drinksData[@"next_page_url"] == (id)[NSNull null]) {
            drink.nextPage = @"null";
        }
        else {
            drink.nextPage = drinksData[@"next_page_url"];
        }

        [self.drinks addObject:drink];
    }
}

- (void) addDrinkToShoopingCart: (int) index quantity:(int) quantity{
    DrinkModel *drinkSelected = [_drinks objectAtIndex:index];
    drinkSelected.quantity = quantity;
    [shoppingCartViewModel addDrinkToArray:drinkSelected];
//    shoppingCartViewModel = delegate;
    
//    [delegate addDrinkToShoopingCart:drinkSelected];
    
//    NSLog(@"index: %d, quantity: %d",index,quantity);
}


@end
