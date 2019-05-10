//
//  DrinksViewModel.m
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/6/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "DrinksViewModel.h"
#import "RequestModel.h"
#import "ShoppingCartViewModel.h"
#import "Appdelegate.h"

@interface DrinksViewModel ()
@property (nonatomic, strong) NSMutableArray<NSMutableDictionary *> *drinksDictionary;
@property (nonatomic, strong) RequestModel *requestModel;
@property (nonatomic, strong) ShoppingCartViewModel *shoppingCartViewModel;
@property (nonatomic, strong) AppDelegate *appDelegate;
- (void) saveDrinkToUserDefaults;
- (void) createDrinkDictionary: (DrinkModel *) drinkSelected;
@end
@implementation DrinksViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cartArray = [NSMutableArray new];
        self.drinksDictionary = [NSMutableArray new];
        self.shoppingCartViewModel = [[ShoppingCartViewModel alloc] init];
        self.requestModel = [[RequestModel alloc] init];
        self.drinks = [NSMutableArray new];
        self.appDelegate = [[AppDelegate alloc]init];
    }
    return self;
}

- (void)createDrinks {
    NSString *defaultUrl = @"http://applicorera3jjjs.com/api/mobile/categories/14/products?page=1";
    NSDictionary *drinksData = [self.requestModel getDataFromJson:defaultUrl];
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
    self.requestModel = [[RequestModel alloc] init];
    self.drinks = [NSMutableArray new];
    NSDictionary *drinksData = [self.requestModel getDataFromJson:url];
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
    
    BOOL newDrink = YES;
    for (int i = 0; i < [self.cartArray count]; i++){
        if ([[self.drinks objectAtIndex:index].name isEqualToString: [self.cartArray objectAtIndex:i].name]) {
            int newQuantity = [[self.cartArray objectAtIndex:i].quantity intValue] + [quantity intValue];
            [self.cartArray objectAtIndex:i].quantity = @(newQuantity);
            [[self.drinksDictionary objectAtIndex: i] setObject: @(newQuantity) forKey:@"quantity"];
            newDrink = NO;
        }
    }
    if (newDrink){
        [self.cartArray addObject:drinkSelected];
        [self createDrinkDictionary:drinkSelected];
    }
    [self saveDrinkToUserDefaults];
}

- (void) createDrinkDictionary: (DrinkModel *) drinkSelected{
    NSMutableDictionary *drinkDictionary = [NSMutableDictionary dictionary];
    [drinkDictionary setObject: drinkSelected.name  forKey: @"name"];
    [drinkDictionary setObject: drinkSelected.price forKey: @"price"];
    [drinkDictionary setObject: drinkSelected.image forKey: @"urlImage"];
    [drinkDictionary setObject: drinkSelected.quantity forKey: @"quantity"];
    [self.drinksDictionary addObject: drinkDictionary];
}

#pragma mark -
#pragma mark userDefaults
- (void)saveDrinkToUserDefaults{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject: self.drinksDictionary forKey:@"drinksDictionary"];
    [userDefaults synchronize];
}

- (void)loadDrinksFromUserDefaults{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"drinksDictionary"] == nil){
        
    }else {
        NSMutableArray<NSMutableDictionary *> *drinksInUserDefaults = [userDefaults objectForKey:@"drinksDictionary"];
        for (int i = 0; i < [drinksInUserDefaults count]; i++){
            DrinkModel *drink = [[DrinkModel alloc]init];
            drink.name = [[drinksInUserDefaults objectAtIndex:i] objectForKey:@"name"];
            drink.price = [[drinksInUserDefaults objectAtIndex:i] objectForKey:@"price"];
            drink.image = [[drinksInUserDefaults objectAtIndex:i] objectForKey:@"urlImage"];
            drink.quantity = [[drinksInUserDefaults objectAtIndex:i] objectForKey:@"quantity"];
            [self.cartArray addObject:drink];
            NSMutableDictionary *dictionaryLoaded = [NSMutableDictionary new];
            [dictionaryLoaded setObject: [[drinksInUserDefaults objectAtIndex:i] objectForKey:@"name"] forKey:@"name"];
            [dictionaryLoaded setObject: [[drinksInUserDefaults objectAtIndex:i] objectForKey:@"price"] forKey:@"price"];
            [dictionaryLoaded setObject: [[drinksInUserDefaults objectAtIndex:i] objectForKey:@"urlImage"] forKey:@"urlImage"];
            [dictionaryLoaded setObject: [[drinksInUserDefaults objectAtIndex:i] objectForKey:@"quantity"] forKey:@"quantity"];
            [self.drinksDictionary addObject: dictionaryLoaded];
        }
    }
}

@end
