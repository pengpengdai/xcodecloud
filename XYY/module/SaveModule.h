//
//  SaveModule.h
//  XYY
//
//  Created by 代代朋朋 on 2022/6/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaveModule : NSObject

@property(nonatomic,strong)NSString *password;

@property(nonatomic,strong)NSDate *time;

@property(nonatomic,strong)NSString *randomStr;

@property(nonatomic,strong)NSString *content;

@end

NS_ASSUME_NONNULL_END
