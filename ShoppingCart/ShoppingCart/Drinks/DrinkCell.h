//
//  DrinkCell.h
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/7/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrinkCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *drinkImage;
@property (weak, nonatomic) IBOutlet UILabel *drinkTitle;
@property (weak, nonatomic) IBOutlet UILabel *drinkPrice;

@end

NS_ASSUME_NONNULL_END
