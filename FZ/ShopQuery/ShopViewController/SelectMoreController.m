//
//  SelectMoreController.m
//  FZ
//
//  Created by mengdy on 16/12/6.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "SelectMoreController.h"
#import "ContactController.h"
@interface SelectMoreController ()

@property (nonatomic,strong)NSArray *arrays;//数据源
@property (nonatomic,strong)NSMutableArray *contacts;
@property (nonatomic,assign)CGFloat lastX;

@end

@implementation SelectMoreController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lastX = 0;
     self.title  = @"写信";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.contacts = [NSMutableArray array];
    UILabel *recipientlb = [[UILabel alloc]initWithFrame:CGRectMake(kViewWith(10), kViewHight(20), kScreenWith - kViewWith(20), kViewHight(40))];
    recipientlb.text = @"收件人:";
    recipientlb.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    recipientlb.backgroundColor = [UIColor clearColor];
    recipientlb.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:recipientlb];
    
    UIButton *addContactBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWith - kViewWith(50), kViewHight(40)+kViewWith(10), kViewWith(30), kViewWith(30))];
    [addContactBtn setImage:[UIImage imageNamed:@"me20"] forState:UIControlStateNormal];
    [addContactBtn addTarget:self action:@selector(addRecipientContact:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addContactBtn];
    
    UIView *addContactLineView = [[UIView alloc]initWithFrame:CGRectMake(kViewWith(10), kViewHight(100), kScreenWith - kViewWith(20), 0.5)];
    addContactLineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:addContactLineView];
    
    
}

-(void)addRecipientContact:(UIButton *)sender {

    ContactController * contact = [[ContactController alloc]init];
    [contact mySelectBlock:^(NSArray *array) {
        
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]};
        self.arrays = [NSArray arrayWithArray:array];
        if (self.arrays.count>0) {
            NSLog(@"_contacts.count : %lu, %lu",(unsigned long)_contacts.count,(unsigned long)self.arrays.count);
            for (int i = 0; i <self.arrays.count; i ++) {
                
                NSLog(@"这个长度: %f",_lastX);
                NSString *title = [self.arrays objectAtIndex:i];
                CGSize size = [title sizeWithAttributes:dic];
                UIButton *contactBtn = [[UIButton alloc]initWithFrame:CGRectMake(kViewWith(10)+_lastX +kViewWith(5), kViewHight(40)+(kViewHight(40)-size.height),size.width+kViewWith(5), size.height)];
                [contactBtn setTitle:title forState:UIControlStateNormal];
                contactBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                [contactBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                contactBtn.tag = i+100;
                CGRect frame = contactBtn.frame;
                _lastX = frame.origin.x + frame.size.width;
                [contactBtn addTarget:self action:@selector(deleteReciContact:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:contactBtn];
                [_contacts addObject:contactBtn];
            }
        }

    }];

    [self.navigationController pushViewController:contact animated:YES];
}


-(void)deleteReciContact:(UIButton *)sender{


    
    
    
    


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
























@end
