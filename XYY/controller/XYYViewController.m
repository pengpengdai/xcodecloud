//
//  XYYViewController.m
//  XYY
//
//  Created by 代代朋朋 on 2022/6/5.
//

#import "XYYViewController.h"
#import <Masonry/Masonry.h>
#import "DecryptionViewController.h"
#import "SpeakViewController.h"
#import "SecretViewController.h"

@interface XYYViewController ()

@property(nonatomic,strong)UIButton *wantSayBtn;

@property(nonatomic,strong)UIButton *encryptionBtn;

@property(nonatomic,strong)UIButton *passwordBtn;

@property(nonatomic,strong)UIButton *decryptionBtn;

@end

@implementation XYYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self wantSayBtn];
    [self encryptionBtn];
    [self passwordBtn];
    [self decryptionBtn];
}

- (UIButton *)wantSayBtn{
    if (!_wantSayBtn) {
        _wantSayBtn = [[UIButton alloc]init];
        [_wantSayBtn setTitle:@"想说" forState:UIControlStateNormal];
        [_wantSayBtn setBackgroundColor:[UIColor redColor]];
        _wantSayBtn.clipsToBounds = YES;
        _wantSayBtn.layer.cornerRadius = 50;
        _wantSayBtn.layer.masksToBounds = YES;
        _wantSayBtn.titleLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];
        [_wantSayBtn addTarget:self action:@selector(wantSayClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_wantSayBtn];
        
        [_wantSayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).mas_offset(-250);
            make.width.height.mas_offset(100);
        }];
    }
    return _wantSayBtn;
}

- (UIButton *)encryptionBtn{
    if (!_encryptionBtn) {
        _encryptionBtn = [[UIButton alloc]init];
        [_encryptionBtn setTitle:@"记录" forState:UIControlStateNormal];
        [_encryptionBtn setBackgroundColor:[UIColor redColor]];
        _encryptionBtn.clipsToBounds = YES;
        _encryptionBtn.layer.cornerRadius = 50;
        _encryptionBtn.layer.masksToBounds = YES;
        _encryptionBtn.titleLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];
        [_encryptionBtn addTarget:self action:@selector(encryptionClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_encryptionBtn];
        
        [_encryptionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).mas_offset(-100);
            make.width.height.mas_offset(100);
        }];
    }
    return _encryptionBtn;
}

- (UIButton *)passwordBtn{
    if (!_passwordBtn) {
        _passwordBtn = [[UIButton alloc]init];
        [_passwordBtn setTitle:@"密码" forState:UIControlStateNormal];
        [_passwordBtn setBackgroundColor:[UIColor redColor]];
        _passwordBtn.clipsToBounds = YES;
        _passwordBtn.layer.cornerRadius = 50;
        _passwordBtn.layer.masksToBounds = YES;
        _passwordBtn.titleLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];
        [_passwordBtn addTarget:self action:@selector(passworkClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_passwordBtn];
        
        [_passwordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).mas_offset(50);
            make.width.height.mas_offset(100);
        }];
    }
    return _passwordBtn;
}

- (UIButton *)decryptionBtn{
    if (!_decryptionBtn) {
        _decryptionBtn = [[UIButton alloc]init];
        [_decryptionBtn setTitle:@"解密" forState:UIControlStateNormal];
        [_decryptionBtn setBackgroundColor:[UIColor redColor]];
        _decryptionBtn.clipsToBounds = YES;
        _decryptionBtn.layer.cornerRadius = 50;
        _decryptionBtn.layer.masksToBounds = YES;
        _decryptionBtn.titleLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];
        [_decryptionBtn addTarget:self action:@selector(decryptionClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_decryptionBtn];
        
        [_decryptionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).mas_offset(200);
            make.width.height.mas_offset(100);
        }];
    }
    return _decryptionBtn;
}

- (void)encryptionClick:(UIButton *)btn{
    SecretViewController *vc = [SecretViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)wantSayClick:(UIButton *)btn{
    SpeakViewController *vc = [SpeakViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)passworkClick:(UIButton *)btn{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        //增加确定按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            //获取第1个输入框；
        UITextField *titleTextField = alertController.textFields.firstObject;
        if ([titleTextField.text isEqualToString:@"lanyun5211314"]) {
            SecretViewController *vc = [SecretViewController new];
            vc.isPassword = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            UIAlertController *passAlert = [UIAlertController alertControllerWithTitle:@"密码验证失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [passAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            }]];
            [self presentViewController:passAlert animated:true completion:nil];
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入密码";
        textField.secureTextEntry = YES;
    }];
    [self presentViewController:alertController animated:true completion:nil];

}

- (void)decryptionClick:(UIButton *)btn{
    DecryptionViewController *vc = [DecryptionViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
