//
//  DrinksViewModel.h
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/6/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrinkModel.h"
//@class DrinkModel;

@class DrinksViewModel;
NS_ASSUME_NONNULL_BEGIN

//@protocol DrinkViewModelDelegate <NSObject>
//- (void)addDrinkToShoopingCart:(DrinkModel *)drink;
//@end

@interface DrinksViewModel : NSObject
@property (nonatomic, strong) NSMutableArray<DrinkModel *> *cartArray;
@property (nonatomic, strong) NSMutableArray<DrinkModel *> *drinks;

- (void) createDrinks;
- (void) requestNextPage: (NSString *) url;
- (void) addDrinkToShoopingCart: (int) index quantity:(NSNumber *) quantity;
- (void) saveDrinkToUserDefaults: (int) drinkIndex quantity:(int) quantity;
- (void) loadDrinkFromUserDefaults;
@end

NS_ASSUME_NONNULL_END
