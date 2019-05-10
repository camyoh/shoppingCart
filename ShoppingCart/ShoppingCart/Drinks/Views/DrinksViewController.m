//
//  DrinksViewController.m
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/2/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "DrinksViewController.h"
#import "DrinksViewModel.h"

#import "ShoppingCartViewController.h"

@interface DrinksViewController () <UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *drinksTableView;

@end

@implementation DrinksViewController

int numberOfRowx = 0;

NSMutableArray<DrinkModel *> *drinksNextPage;
DrinksViewModel *drinksViewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    drinksViewModel = [[DrinksViewModel alloc] init];
    [drinksViewModel createDrinks];
    
    [drinksViewModel loadDrinkFromUserDefaults];
    _drinks = [drinksViewModel drinks];
    numberOfRowx = (int)[_drinks count];
    NSLog(@"%@",[_drinks objectAtIndex:0].name);
    NSLog(@"%lu", (unsigned long)[_drinks count]);
    self.tabBarController.delegate = self;
    [_drinksTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    static NSString *cellId = @"drinkCell";
    DrinkCell *cell = (DrinkCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DrinkCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSString *imageUrl = [self->_drinks objectAtIndex:indexPath.row].image;
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:imageUrl]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.drinkImage.image = [UIImage imageWithData: data];
        });
    });
    
    cell.addDrink.tag = indexPath.row;
    [cell.addDrink addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.drinkTitle.text = [_drinks objectAtIndex:indexPath.row].name;
    NSString *drinkPrice = @"$ ";
    cell.drinkPrice.text = [drinkPrice stringByAppendingString: [[_drinks objectAtIndex:indexPath.row].price stringValue]] ;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numberOfRowx;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView
                  willDecelerate:(BOOL)decelerate
{
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 50;
    if(y > h + reload_distance) {
        if (![_drinks[(int)[_drinks count]-1].nextPage  isEqual: @"null"]){
            [self requestNextPage];
        }
    }
}

- (void) requestNextPage {
    [drinksViewModel requestNextPage:_drinks[(int)[_drinks count]-1].nextPage];
    drinksNextPage = [drinksViewModel drinks];
    [_drinks addObjectsFromArray:drinksNextPage];
    numberOfRowx = (int)[_drinks count];
    drinksViewModel.drinks = _drinks;
    [self.drinksTableView reloadData];
}

- (void) showAlert: (id)sender {
    UIButton *senderButton = (UIButton *) sender;
    int drinkSelected = (int)senderButton.tag;
    __block int drinkQuantity = 0;
    
    NSString *message = @"Escoge la cantidad de ";
    NSString *drinkName = [_drinks objectAtIndex:drinkSelected].name;
    NSString *complementMessage = @" que quieres agregar al carrito";
    message = [message stringByAppendingString:drinkName];
    message = [message stringByAppendingString:complementMessage];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Agregar Producto"
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Cantidad:";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Agregar"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    NSArray<UITextField *> *drinkQuantityField = [alert textFields];
                                    if ([[drinkQuantityField objectAtIndex:0].text  isEqual: @""] || [[drinkQuantityField objectAtIndex:0].text  isEqual: @"0"]){
                                        NSLog(@"null");
                                    }
                                    else {
                                        drinkQuantity = [[drinkQuantityField objectAtIndex:0].text intValue];
                                        [drinksViewModel addDrinkToShoopingCart:drinkSelected quantity: @(drinkQuantity)];
                                        [drinksViewModel saveDrinkToUserDefaults:(int)senderButton.tag quantity:drinkQuantity];
                                    }
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancelar"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //actions
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:ShoppingCartViewController.class]){
        ShoppingCartViewController *shoppingCartViewController = (ShoppingCartViewController *)viewController;
        shoppingCartViewController.shoppingCartViewModel.cartArray = drinksViewModel.cartArray;
        NSLog(@"%@", drinksViewModel.cartArray);
    }
}

@end
