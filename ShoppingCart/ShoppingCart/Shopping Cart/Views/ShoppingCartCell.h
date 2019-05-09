//
//  ShoppingCartCell.h
//  ShoppingCart
//
//  Created by Yoh on 5/8/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *drinkImage;
@property (weak, nonatomic) IBOutlet UILabel *drinkQuantity;
@property (weak, nonatomic) IBOutlet UILabel *drinkPrice;
@property (weak, nonatomic) IBOutlet UILabel *drinkTitle;

@end

NS_ASSUME_NONNULL_END
