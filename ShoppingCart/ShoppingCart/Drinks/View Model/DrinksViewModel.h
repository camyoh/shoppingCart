//
//  DrinksViewModel.h
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/6/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrinkModel.h"

@class DrinksViewModel;
NS_ASSUME_NONNULL_BEGIN

@interface DrinksViewModel : NSObject
@property (nonatomic, strong) NSMutableArray<DrinkModel *> *cartArray;
@property (nonatomic, strong) NSMutableArray<DrinkModel *> *drinks;

- (void) createDrinks;
- (void) requestNextPage: (NSString *) url;
- (void) addDrinkToShoopingCart: (int) index quantity:(NSNumber *) quantity;

- (void) loadDrinksFromUserDefaults;
@end

NS_ASSUME_NONNULL_END
