//
//  ShoppingCartViewController.m
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/2/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "ShoppingCartViewController.h"


@interface ShoppingCartViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *shoppingCartTableView;
@end

@implementation ShoppingCartViewController

- (void)viewDidAppear:(BOOL)animated{
    [_shoppingCartTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _shoppingCartViewModel = [[ShoppingCartViewModel alloc]init];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (_shoppingCartViewModel.cartArray.count == 0) {
        static NSString *cellId = @"emptyCell";
        EmptyCell *cell = (EmptyCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EmptyCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        return cell;
    }else{
        static NSString *cellId = @"shoppingCartCell";
        ShoppingCartCell *cell = (ShoppingCartCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShoppingCartCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSString *imageUrl = [self->_shoppingCartViewModel.cartArray objectAtIndex:indexPath.row].image;
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:imageUrl]];
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.drinkImage.image = [UIImage imageWithData: data];
            });
            //        [data release];
        });
        
        cell.drinkTitle.text = [_shoppingCartViewModel.cartArray objectAtIndex:indexPath.row].name;
        NSString *quantity = [@("x ") stringByAppendingString: [@([_shoppingCartViewModel.cartArray objectAtIndex:indexPath.row].quantity) stringValue] ];
        cell.drinkQuantity.text = quantity;
        int finalPrice = [[_shoppingCartViewModel.cartArray objectAtIndex:indexPath.row].price intValue]*[_shoppingCartViewModel.cartArray objectAtIndex:indexPath.row].quantity;
        cell.drinkPrice.text = [@("$ ") stringByAppendingString:[@(finalPrice) stringValue]];
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_shoppingCartViewModel.cartArray.count == 0) {
        return 1;
    }else {
        return _shoppingCartViewModel.cartArray.count;
    }
}

@end
