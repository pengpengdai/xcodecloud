//
//  ViewController.m
//  XYY
//
//  Created by 代代朋朋 on 2022/6/4.
//

#import "SpeakViewController.h"
#import "BRPlaceholderTextView.h"
#import "SaveModule.h"
#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>
#import <MMKV/MMKV.h>

@interface SpeakViewController ()

@property(nonatomic,strong)BRPlaceholderTextView *loveTextView;

@property(nonatomic,strong)BRPlaceholderTextView *passwordTextField;

@property(nonatomic,strong)BRPlaceholderTextView *encryptionTextView;

@property(nonatomic,strong)BRPlaceholderTextView *decryptionTextView;

@property(nonatomic,strong)UIButton *saveBtn;

@property(nonatomic,strong)MMKV *mmkv;

@end

@implementation SpeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loveTextView];
    [self passwordTextField];
//    [self encryptionTextView];
    [self saveBtn];
    self.mmkv = [MMKV defaultMMKV];
}

- (BRPlaceholderTextView *)loveTextView{
    if (!_loveTextView) {
        _loveTextView = [BRPlaceholderTextView new];
        _loveTextView.placeholder = @"请输入想要加密的文字";
        _loveTextView.layer.borderWidth = 1;
        _loveTextView.layer.borderColor = [UIColor redColor].CGColor;
        _loveTextView.layer.cornerRadius = 6;
        [self.view addSubview:_loveTextView];
        
        [_loveTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.top.equalTo(self.view).offset(140);
            make.right.equalTo(self.view).offset(-20);
            make.height.mas_offset(460);

        }];
        
        UILabel *label = [UILabel new];
        label.text = @"我想对你说";
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
        _passwordTextField.layer.borderWidth = 1;
        _passwordTextField.secureTextEntry = YES;//设置密文
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
        _encryptionTextView.layer.borderWidth = 1;
        _encryptionTextView.layer.borderColor = [UIColor redColor].CGColor;
        _encryptionTextView.layer.cornerRadius = 6;
        _encryptionTextView.hidden = YES;
        [self.view addSubview:_encryptionTextView];
        
        [_encryptionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.top.equalTo(self.passwordTextField.mas_bottom).offset(40);
            make.right.equalTo(self.view).offset(-20);
            make.height.mas_offset(100);

        }];
        
        
        UILabel *label = [UILabel new];
        label.text = @"加密";
        label.hidden = YES;
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
- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc]init];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setBackgroundColor:[UIColor redColor]];
        _saveBtn.clipsToBounds = YES;
        _saveBtn.layer.cornerRadius = 50;
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];
        [_saveBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_saveBtn];
        
        [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view).mas_offset(-50);
            make.width.height.mas_offset(100);
        }];
    }
    return _saveBtn;
}

- (void)saveClick:(UIButton *)btn{
    NSString *random = [self randomString:16];
    SaveModule *saveModule = [SaveModule new];
    saveModule.password = self.passwordTextField.text ?: @"love5211314";
    saveModule.time = [NSDate date];
    saveModule.randomStr = random;
    saveModule.content = self.loveTextView.text;
    NSDictionary *dict = [saveModule yy_modelToJSONObject];
    
    [self.mmkv setObject:dict forKey:random];
    NSLog(@"%@",[self.mmkv allKeys]);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存秘密" message: @"保存成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:confirm];
    [self presentViewController:alert animated:true completion:nil];
}

- (NSString *)randomString:(NSInteger)number {
    
    NSString *ramdom;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1; i ; i ++) {
        int a = (arc4random() % 122);
        if ((a >= 65 && a <= 90) || a > 96||(a >=48 &&a<=57)) {
            char c = (char)a;
            [array addObject:[NSString stringWithFormat:@"%c",c]];
            if (array.count == number) {
                break;
            }
        } else continue;
    }
    ramdom = [array componentsJoinedByString:@""];
    return ramdom;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
