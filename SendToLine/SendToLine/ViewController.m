//
//  ViewController.m
//  SendToLine
//
//  Created by 廣川政樹 on 2013/04/26.
//  Copyright (c) 2013年 Dolice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self initSendToLineButton];
  [self initTextField];
}

//LINEで送るボタン初期化
- (void)initSendToLineButton
{
  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button.frame = CGRectMake(50, 100, 220, 36);
  [button setTitle:@"LINE で送る" forState:UIControlStateNormal];
  [button addTarget:self
             action:@selector(sendToLineButtonWasTapped:)
   forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  
}

//LINEで送る
- (void)sendToLineButtonWasTapped:(id)sender {
  NSString *plainString = _textField.text;
  NSString *contentKey = (__bridge NSString *)
    CFURLCreateStringByAddingPercentEscapes(NULL,
                                            (CFStringRef)plainString,
                                            NULL,
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            kCFStringEncodingUTF8 );
  
  NSString *contentType = @"text";
  NSString *urlString = [NSString
                         stringWithFormat: @"http://line.naver.jp/R/msg/%@/?%@",
                         contentType, contentKey];
  NSURL *url = [NSURL URLWithString:urlString];
  [[UIApplication sharedApplication] openURL:url];
}

//テキストフィールド初期化
- (void)initTextField
{
  _textField = [[UITextField alloc]
                initWithFrame:CGRectMake(50, 50, 220, 36)];
  [_textField setBorderStyle:UITextBorderStyleRoundedRect];
  [self.view addSubview:_textField];
}

@end
