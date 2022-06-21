//
//  DecryptionViewController.m
//  XYY
//
//  Created by 代代朋朋 on 2022/6/5.
//

#import "DecryptionViewController.h"
#import "BRPlaceholderTextView.h"
#import "SaveModule.h"
#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>
#import <MMKV/MMKV.h>

@interface DecryptionViewController ()

@property(nonatomic,strong)BRPlaceholderTextView *loveTextView;

@property(nonatomic,strong)BRPlaceholderTextView *passwordTextField;

@property(nonatomic,strong)BRPlaceholderTextView *encryptionTextView;

@property(nonatomic,strong)UIButton *decryptionBtn;

@end

@implementation DecryptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loveTextView];
    [self passwordTextField];
    [self encryptionTextView];
    [self decryptionBtn];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (BRPlaceholderTextView *)loveTextView{
    if (!_loveTextView) {
        _loveTextView = [BRPlaceholderTextView new];
        _loveTextView.placeholder = @"请输入您的密文";
        _loveTextView.layer.borderWidth = 1;
        _loveTextView.layer.borderColor = [UIColor redColor].CGColor;
        _loveTextView.layer.cornerRadius = 6;
        [self.view addSubview:_loveTextView];
        
        [_loveTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.top.equalTo(self.view).offset(140);
            make.right.equalTo(self.view).offset(-20);
            make.height.mas_offset(30);

        }];
        
        UILabel *label = [UILabel new];
        label.text = @"密文";
        label.font = [UIFont boldSystemFontOfSize:16];
        label.textColor = [UIColor lightGrayColor];
        [self.view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_loveTextView);
            make.bottom.equalTo(_loveTextView.mas_top).offset(-10);
        }];
    }
    return _loveTextView;
}

- (BRPlaceholderTextView *)passwordTextField{
    if (!_passwordTextField) {
        _passwordTextField = [BRPlaceholderTextView new];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.layer.borderWidth = 1;
        _passwordTextField.layer.borderColor = [UIColor redColor].CGColor;
        _passwordTextField.layer.cornerRadius = 6;
        [self.view addSubview:_passwordTextField];
        
        [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.top.equalTo(self.loveTextView.mas_bottom).offset(40);
            make.right.equalTo(self.view).offset(-20);
            make.height.mas_offset(30);

        }];
        
        UILabel *label = [UILabel new];
        label.text = @"密码";
        label.font = [UIFont boldSystemFontOfSize:16];
        label.textColor = [UIColor lightGrayColor];
        [self.view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_passwordTextField);
            make.bottom.equalTo(_passwordTextField.mas_top).offset(-10);
        }];
    }
    return _passwordTextField;
}
- (BRPlaceholderTextView *)encryptionTextView{
    if (!_encryptionTextView) {
        _encryptionTextView = [BRPlaceholderTextView new];
        _encryptionTextView.placeholder = @"加密结果";
        _encryptionTextView.secureTextEntry = YES;
        _encryptionTextView.layer.borderWidth = 1;
        _encryptionTextView.layer.borderColor = [UIColor redColor].CGColor;
        _encryptionTextView.layer.cornerRadius = 6;
        [self.view addSubview:_encryptionTextView];
        
        [_encryptionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.top.equalTo(self.passwordTextField.mas_bottom).offset(40);
            make.right.equalTo(self.view).offset(-20);
            make.height.mas_offset(400);
        }];
        
        UILabel *label = [UILabel new];
        label.text = @"他想对你说";
        label.font = [UIFont boldSystemFontOfSize:16];
        label.textColor = [UIColor lightGrayColor];
        [self.view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_encryptionTextView);
            make.bottom.equalTo(_encryptionTextView.mas_top).offset(-10);
        }];
    }
    return _encryptionTextView;
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
            make.bottom.equalTo(self.view).mas_offset(-50);
            make.width.height.mas_offset(100);
        }];
    }
    return _decryptionBtn;
}

- (void)decryptionClick:(UIButton *)btn{
    MMKV *mmkv = [MMKV defaultMMKV];
    NSDictionary *dict = [mmkv getObjectOfClass:[NSDictionary class] forKey:self.loveTextView.text];
    SaveModule *module = [SaveModule yy_modelWithJSON:dict];
    
    if ([self.passwordTextField.text isEqualToString:module.password]) {
        self.encryptionTextView.text = module.content;
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"结果" message:@"密码输入有误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert animated:true completion:nil];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
