//
//  ShoppingCartViewController.h
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/2/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmptyCell.h"
#import "ShoppingCartCell.h"
#import "ShoppingCartCell.h"
#import "ShoppingCartViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCartViewController : UIViewController
@property (nonatomic, strong) ShoppingCartViewModel *shoppingCartViewModel;
//-(void)reloadTableData;
@end

NS_ASSUME_NONNULL_END
