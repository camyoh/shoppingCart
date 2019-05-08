//
//  RequestModel.h
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/6/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrinkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestModel : NSObject
- (NSDictionary *)getDataFromJson:(NSString *) url;
@end

NS_ASSUME_NONNULL_END
