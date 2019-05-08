//
//  DrinksViewModel.h
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/6/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DrinkModel;

NS_ASSUME_NONNULL_BEGIN

@interface DrinksViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<DrinkModel *> *drinks;

- (void) createDrinks;
- (void) requestNextPage: (NSString *) url;
@end

NS_ASSUME_NONNULL_END
