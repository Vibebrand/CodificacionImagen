//
//  ImageViewController.h
//  CodificacionImagen
//
//  Created by Luis Alejandro Rangel Sánchez on 04/02/13.
//  Copyright (c) 2013 Vibebrand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *urlImage;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UITextView *textArea;

@end
