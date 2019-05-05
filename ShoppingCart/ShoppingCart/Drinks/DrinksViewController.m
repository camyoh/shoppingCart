//
//  DrinksViewController.m
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/2/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "DrinksViewController.h"
#import "Drink.h"

@interface DrinksViewController ()

@end

@implementation DrinksViewController

struct Drink
{
    NSString *name;
    NSString *image;
    NSNumber *price;
};

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    request();
    
    
}

void request(){
    struct Drink drink;
    
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
    }
    else {
        NSDictionary *drinks = allDrinksData[@"data"];
        drink.name = drinks[@"data"][0][@"name"];
        drink.image = drinks[@"data"][0][@"image"];
        drink.price = drinks[@"data"][0][@"store"][@"price"];
//        NSLog(@"Drinks: %@", drinks[@"data"][0][@"store"][@"price"]);

        NSLog(@"Drink Name: %@", drink.name);
        NSLog(@"Drink Price: %@", drink.price);
        NSLog(@"Drink Image: %@", drink.image);
    }
}


@end
