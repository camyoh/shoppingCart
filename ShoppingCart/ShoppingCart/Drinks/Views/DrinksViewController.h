//
//  DrinksViewController.h
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/2/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrinkCell.h"
#import "DrinkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DrinksViewController : UIViewController
@property  (nonatomic, strong)NSMutableArray<DrinkModel *> *drinks;
@end

NS_ASSUME_NONNULL_END
