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

@interface DrinksViewModel ()
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *drinksArray;

@end
@implementation DrinksViewModel

RequestModel *requestModel;
ShoppingCartViewModel *shoppingCartViewModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cartArray = [NSMutableArray new];
        self.drinksArray = [NSMutableArray new];
    }
    return self;
}

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

- (void) addDrinkToShoopingCart: (int) index quantity:(NSNumber *) quantity{
    DrinkModel *drinkSelected = [[self.drinks objectAtIndex:index] copy];
    drinkSelected.quantity = quantity;
    NSUInteger totalDrinks = [self.cartArray count];
    
    NSMutableArray *drinkArray = [NSMutableArray new];
    [drinkArray insertObject:drinkSelected.name atIndex:0];
    [drinkArray insertObject:drinkSelected.quantity atIndex:1];
    [drinkArray insertObject:drinkSelected.price atIndex:2];
    [drinkArray insertObject:drinkSelected.image atIndex:3];
    
    BOOL newDrink = YES;
    NSLog(@"bebida ya extiste");
    for (int i = 0; i < totalDrinks; i++){
        if ([[self.drinks objectAtIndex:index].name isEqualToString: [self.cartArray objectAtIndex:i].name]) {
            int newQuantity = [[self.cartArray objectAtIndex:i].quantity intValue] + [quantity intValue];
            [self.cartArray objectAtIndex:i].quantity = @(newQuantity);
            NSLog(@"bebida ya extiste");
            newDrink = NO;
        }
    }
    if (newDrink){
        [self.cartArray addObject:drinkSelected];
        [self.drinksArray addObject:drinkArray];
    }
    
    
    
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject: self.drinksArray forKey:@"drinksArray"];
    [userDefaults synchronize];
}

#pragma mark -
#pragma mark userDefaults
- (void)saveDrinkToUserDefaults:(int)drinkIndex quantity:(int)quantity {
    
}

- (void)loadDrinkFromUserDefaults{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray<NSMutableArray *> *drinksArrayFromUserDefaults;
    drinksArrayFromUserDefaults = [userDefaults objectForKey:@"drinksArray"];
    for (int i = 0; i < [drinksArrayFromUserDefaults count]; i++){
        DrinkModel *drink = [[DrinkModel alloc]init];
        drink.name = [[drinksArrayFromUserDefaults objectAtIndex: i] objectAtIndex: 0];
        drink.quantity = [[drinksArrayFromUserDefaults objectAtIndex: i] objectAtIndex: 1];
        drink.price = [[drinksArrayFromUserDefaults objectAtIndex: i] objectAtIndex: 2];
        drink.image = [[drinksArrayFromUserDefaults objectAtIndex: i] objectAtIndex: 3];
        [self.cartArray addObject:drink];
        [self.drinksArray addObject: [drinksArrayFromUserDefaults objectAtIndex:i]];
    }
}

@end
