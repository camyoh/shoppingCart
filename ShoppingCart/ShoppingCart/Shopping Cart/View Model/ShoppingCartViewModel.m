//
//  ShoppingCartViewModel.m
//  ShoppingCart
//
//  Created by Yoh on 5/8/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "ShoppingCartViewModel.h"
//#import "DrinksViewModel.h"

@implementation ShoppingCartViewModel
//DrinksViewModel *drinkViewModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
//        drinkViewModel = [[DrinksViewModel alloc] init];
//        drinkViewModel.delegate = self;
//        self.drinks = [NSMutableArray new];
    }
    return self;
}

- (void)addDrinkToArray:(DrinkModel *)drink{
//    [self.cartArray addObject:drink];
    NSLog(@"Drink added");
}

//    [self.drinks addObject:drink];
//    NSLog(@"llamando protocolo");
//}

@end
