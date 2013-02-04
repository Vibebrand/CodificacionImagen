//
//  ImageViewController.m
//  CodificacionImagen
//
//  Created by Luis Alejandro Rangel Sánchez on 04/02/13.
//  Copyright (c) 2013 Vibebrand. All rights reserved.
//

#import "ImageViewController.h"
#import "GTMBase64.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.urlImage setText: @"http://192.168.100.23:8000/1.png"];
    [self.urlImage setDelegate: self];
    [self.textArea setText: @""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString * urlImageText = [self.urlImage text];
    NSURL *url = [NSURL URLWithString: urlImageText];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSString * sdata = [self serialize: data];
    NSData * dataRes = [self deserialize: sdata];
    
    
    UIImage *img = [[[UIImage alloc] initWithData:dataRes scale: 1.0] autorelease];
    [self.imageView setImage: img];
    [self.textArea setText: sdata];
    [self.view endEditing: YES];
    
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.imageView setImage: nil];
    [self.textArea setText: @""];
    
    return YES;
}
-(NSString *) serialize:(NSData*)data {
    
    return [GTMBase64 stringByEncodingData:data];
}

/**
 * Deserialize Base64 NSString to NSData
 */
-(NSData*) deserialize: (NSString *) input {
    
    return [GTMBase64 decodeString: input];
    
}

- (void)dealloc {
    [_urlImage release];
    [_imageView release];
    [_textArea release];
    [super dealloc];
}
@end
