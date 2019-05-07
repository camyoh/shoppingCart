//
//  DrinkModel.h
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/6/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrinkModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *nextPage;
@property (nonatomic, strong) NSString *prevPage;
@end

NS_ASSUME_NONNULL_END
