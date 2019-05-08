//
//  RequestModel.m
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/6/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "RequestModel.h"

//@"http://applicorera3jjjs.com/api/mobile/categories/14/products?page=1"

@implementation RequestModel

- (NSDictionary *)getDataFromJson:(NSString *) url{
    NSDictionary *nilDictionary = @{@"key1":@"nil"};
    NSData *jsonRequest = [[NSData alloc] initWithContentsOfURL:
                           [NSURL URLWithString: url]];
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
