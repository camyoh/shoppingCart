//
//  ShoppingCartCell.m
//  ShoppingCart
//
//  Created by Yoh on 5/8/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "ShoppingCartCell.h"

@implementation ShoppingCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.drinkImage.image = nil;
}

@end
