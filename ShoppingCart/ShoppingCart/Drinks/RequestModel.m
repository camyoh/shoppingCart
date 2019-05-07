//
//  RequestModel.m
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/6/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "RequestModel.h"

@implementation RequestModel

- (NSDictionary *)getDataFromJson;{
    NSDictionary *nilDictionary = @{@"key1":@"nil"};
    NSData *jsonRequest = [[NSData alloc] initWithContentsOfURL:
                           [NSURL URLWithString:@"http://applicorera3jjjs.com/api/mobile/categories/14/products?page=1"]];
    NSError *error;
    NSDictionary *allDrinksData = [NSJSONSerialization
                                   JSONObjectWithData:jsonRequest
                                   options:kNilOptions
                                   error:&error];
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
        return nilDictionary;
    }
    else {
        NSDictionary *drinks = allDrinksData[@"data"];
        return drinks;
    }
}


@end
