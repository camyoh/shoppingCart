//
//  DrinksViewController.m
//  ShoppingCart
//
//  Created by Carlos Mendieta on 5/2/19.
//  Copyright © 2019 Carlos Mendieta. All rights reserved.
//

#import "DrinksViewController.h"
#import "DrinksViewModel.h"
#import "DrinkModel.h"

@interface DrinksViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *drinksTableView;

@end

@implementation DrinksViewController

int numberOfRowx = 0;
NSMutableArray<DrinkModel *> *drinks;
NSMutableArray<DrinkModel *> *drinksNextPage;
DrinksViewModel *drinksViewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    drinksViewModel = [[DrinksViewModel alloc] init];
    [drinksViewModel createDrinks];
    drinks = [drinksViewModel drinks];
    numberOfRowx = (int)[drinks count];
    NSLog(@"%@",[drinks objectAtIndex:0].name);
    NSLog(@"%lu", (unsigned long)[drinks count]);
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    static NSString *cellId = @"drinkCell";
    DrinkCell *cell = (DrinkCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DrinkCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSString *imageUrl = [drinks objectAtIndex:indexPath.row].image;
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:imageUrl]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.drinkImage.image = [UIImage imageWithData: data];
        });
//        [data release];
    });
    
    cell.addDrink.tag = indexPath.row;
    [cell.addDrink addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.drinkTitle.text = [drinks objectAtIndex:indexPath.row].name;
    NSString *drinkPrice = @"$ ";
    cell.drinkPrice.text = [drinkPrice stringByAppendingString: [[drinks objectAtIndex:indexPath.row].price stringValue]] ;
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
        if (![drinks[(int)[drinks count]-1].nextPage  isEqual: @"null"]){
            [drinksViewModel requestNextPage:drinks[(int)[drinks count]-1].nextPage];
            drinksNextPage = [drinksViewModel drinks];
            [drinks addObjectsFromArray:drinksNextPage];
            numberOfRowx = (int)[drinks count];
            [self.drinksTableView reloadData];
        }
    }
}

-(void) showAlert: (id)sender {
    UIButton *senderButton = (UIButton *) sender;
    int drinkSelected = (int)senderButton.tag;
    NSLog(@"Current Row = %ld", (long)senderButton.tag);
    NSString *message = @"Escoge la cantidad de ";
    NSString *drinkName = [drinks objectAtIndex:drinkSelected].name;
    NSString *complementMessage = @" que quieres agregar al carrito";
    message = [message stringByAppendingString:drinkName];
    message = [message stringByAppendingString:complementMessage];
    NSLog(@"%@", message);
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Agregar Producto"
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Cantidad:";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
//                                    [self clearAllData];
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    //Add your buttons to alert controller
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
