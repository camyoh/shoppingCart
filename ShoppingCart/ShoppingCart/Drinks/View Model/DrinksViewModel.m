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
@property (nonatomic, strong) NSMutableArray<NSMutableDictionary *> *drinksDictionary;

@end
@implementation DrinksViewModel

RequestModel *requestModel;
ShoppingCartViewModel *shoppingCartViewModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cartArray = [NSMutableArray new];
        self.drinksDictionary = [NSMutableArray new];
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
    
    NSMutableDictionary *drinkDictionary = [NSMutableDictionary dictionary];
    [drinkDictionary setObject: drinkSelected.name  forKey: @"name"];
//    [drinkDictionary setObject: drinkSelected.quantity forKey:  @"quantity"];
    [drinkDictionary setObject: drinkSelected.price forKey:  @"price"];
    [drinkDictionary setObject: drinkSelected.image forKey: @"urlImage"];
    
    BOOL newDrink = YES;
    NSLog(@"bebida ya extiste");
    for (int i = 0; i < totalDrinks; i++){
        if ([[self.drinks objectAtIndex:index].name isEqualToString: [self.cartArray objectAtIndex:i].name]) {
            int newQuantity = [[self.cartArray objectAtIndex:i].quantity intValue] + [quantity intValue];
            [self.cartArray objectAtIndex:i].quantity = @(newQuantity);
            [[self.drinksDictionary objectAtIndex: i] setObject: @(newQuantity) forKey:@"quantity"];
            NSLog(@"bebida ya extiste");
            newDrink = NO;
        }
    }
    if (newDrink){
        [self.cartArray addObject:drinkSelected];
        [drinkDictionary setObject: drinkSelected.quantity forKey:  @"quantity"];
        [self.drinksDictionary addObject: drinkDictionary];
    }
    NSLog(@"%@", self.drinksDictionary);
    
    
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject: self.drinksDictionary forKey:@"drinksDictionary"];
    [userDefaults synchronize];
}

#pragma mark -
#pragma mark userDefaults
- (void)saveDrinkToUserDefaults:(int)drinkIndex quantity:(int)quantity {
    
}

- (void)loadDrinkFromUserDefaults{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"drinksDictionary"] == nil){
        
    }else {
        NSMutableArray<NSMutableDictionary *> *drinksDictionaryLoaded = [userDefaults objectForKey:@"drinksDictionary"];
        NSLog(@"%lu", (unsigned long)[self.drinksDictionary count]);
        for (int i = 0; i < [drinksDictionaryLoaded count]; i++){
            DrinkModel *drink = [[DrinkModel alloc]init];
            drink.name = [[drinksDictionaryLoaded objectAtIndex:i] objectForKey:@"name"];
            drink.price = [[drinksDictionaryLoaded objectAtIndex:i] objectForKey:@"price"];
            drink.image = [[drinksDictionaryLoaded objectAtIndex:i] objectForKey:@"urlImage"];
            drink.quantity = [[drinksDictionaryLoaded objectAtIndex:i] objectForKey:@"quantity"];
            [self.cartArray addObject:drink];
            NSMutableDictionary *dictionaryLoaded = [NSMutableDictionary new];
            [dictionaryLoaded setObject: [[drinksDictionaryLoaded objectAtIndex:i] objectForKey:@"name"] forKey:@"name"];
            [dictionaryLoaded setObject: [[drinksDictionaryLoaded objectAtIndex:i] objectForKey:@"price"] forKey:@"price"];
            [dictionaryLoaded setObject: [[drinksDictionaryLoaded objectAtIndex:i] objectForKey:@"urlImage"] forKey:@"urlImage"];
            [dictionaryLoaded setObject: [[drinksDictionaryLoaded objectAtIndex:i] objectForKey:@"quantity"] forKey:@"quantity"];
            [self.drinksDictionary addObject: dictionaryLoaded];
        }
    }
}

@end
