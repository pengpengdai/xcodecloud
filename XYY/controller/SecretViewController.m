//
//  SecretViewController.m
//  XYY
//
//  Created by 代代朋朋 on 2022/6/5.
//

#import "SecretViewController.h"
#import <MMKV/MMKV.h>
#import "SaveModule.h"
#import <YYModel/YYModel.h>

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

@interface SecretViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation SecretViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self dataSource];
    [self tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        MMKV *mmkv = [MMKV defaultMMKV];
        _dataSource = [NSMutableArray new];
        for (NSString *key in [mmkv allKeys]) {
            NSDictionary *dict = [mmkv getObjectOfClass:[NSDictionary class] forKey:key];
            SaveModule *module = [SaveModule yy_modelWithJSON:dict];
            [_dataSource addObject:module];
        }
    }
    return _dataSource;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellid"];
    }
    SaveModule *module = self.dataSource[indexPath.row];
    cell.textLabel.text = module.randomStr;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:module.time];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%@",self.dataSource[indexPath.row]);
    SaveModule *module = self.dataSource[indexPath.row];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = module.randomStr;

    if (self.isPassword) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码" message:module.password preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert animated:true completion:nil];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
            //增加确定按钮
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                //获取第1个输入框；
                UITextField *titleTextField = alertController.textFields.firstObject;
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"我想对你说" message:[module.password isEqualToString:titleTextField.text] ? module.content : @"密码输入有误" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:confirm];
                [self presentViewController:alert animated:true completion:nil];
            
            }]];
            //增加取消按钮；
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            //定义第一个输入框；
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"请输入密码";
                textField.secureTextEntry = YES;
            }];
            [self presentViewController:alertController animated:true completion:nil];
    }

}

-(void)_deleteSelectIndexPath:(NSIndexPath *)indexPath{
    SaveModule *module = self.dataSource[indexPath.row];
    MMKV *mmkv = [MMKV defaultMMKV];
    [mmkv removeValueForKey:module.randomStr];
    [self.dataSource removeObject:module];
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [self _deleteSelectIndexPath:indexPath];
    }
}

//滑动删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
