//
//  Drink.m
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/2/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "Drink.h"

@interface Drink ()


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageUrl;

//@property (nonatomic) NSUInteger categoryId;

@end

@implementation Drink

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
//        _categoryId = [dictionary[@"category_id"] intValue];
//        _createdAt = dictionary[@"created_at"];
        _name = dictionary[@"name"];
        _imageUrl = dictionary[@"image"];
    }
    return self;
}

@end

