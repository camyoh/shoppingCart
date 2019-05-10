//
//  DrinkModel.m
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/6/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "DrinkModel.h"

@implementation DrinkModel

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    
    DrinkModel *copy = [[DrinkModel allocWithZone: zone] init];

    [copy setName:self.name];
    [copy setImage:self.image];
    [copy setPrice:self.price];
    [copy setQuantity:self.quantity];
    [copy setNextPage:self.nextPage];
    
    return copy;
}

@end
