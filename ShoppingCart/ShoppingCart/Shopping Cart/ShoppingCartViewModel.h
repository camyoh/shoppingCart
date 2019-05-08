//
//  ShoppingCartViewModel.h
//  ShoppingCart
//
//  Created by Yoh on 5/8/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrinksViewModel.h"
#import "DrinkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCartViewModel : NSObject <DrinkViewModelDelegate>
@property (nonatomic, strong) NSMutableArray<DrinkModel *> *drinks;
- (void)addDrinkToArray:(DrinkModel *)drink;
@end

NS_ASSUME_NONNULL_END
