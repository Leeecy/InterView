//
//  SwitchViewController.m
//  Interview
//
//  Created by kiss on 2019/9/19.
//  Copyright © 2019 cl. All rights reserved.
//

#import "SwitchViewController.h"
#import "KSVocieTipCell.h"
@interface SwitchViewController ()

@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[KSVocieTipCell class] forCellReuseIdentifier:kCellIdentifier_KSVocieTipCell];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KSVocieTipCell *cell  =[tableView dequeueReusableCellWithIdentifier:kCellIdentifier_KSVocieTipCell forIndexPath:indexPath];
    
     [cell setTitle:NSLocalizedString(@"充电管理", nil) andDetail:@"开启后,当耳机电量低于30%电池盒才会给耳机充电"];
    hq_weak(cell)
    cell.switchValueChanged = ^(BOOL isOn) {
        hq_strong(cell)
        if (isOn) {
            
            NSLog(@"打开了");
            if (self.vocieTipBlock) {
                self.vocieTipBlock(YES);
            }
            
//            [cell.aswitch setOn:NO];
            
            
        }else{
            NSLog(@"关闭了");
            if (self.vocieTipBlock) {
                self.vocieTipBlock(NO);
            }
            
        }
    };
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [KSVocieTipCell cellHeight];
    
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
