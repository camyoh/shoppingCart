//
//  ShoppingCartViewController.m
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/2/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartViewModel.h"

@interface ShoppingCartViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *shoppingCartTableView;

@end

@implementation ShoppingCartViewController

ShoppingCartViewModel *shoppingCartVM;


- (void)viewDidLoad {
    [super viewDidLoad];
    shoppingCartVM = [[ShoppingCartViewModel alloc]init];
    
    // Do any additional setup after loading the view.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSLog(@"DataLoaded");
    if (shoppingCartVM.drinks.count == 0) {
        static NSString *cellId = @"emptyCell";
        EmptyCell *cell = (EmptyCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EmptyCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        return cell;
    }else{
        static NSString *cellId = @"emptyCell";
        EmptyCell *cell = (EmptyCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EmptyCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.emptyLabel.text = @"hay datos";
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(void)reloadTableData{
    [self.shoppingCartTableView reloadData];
}
@end
