//
//  ImageViewController.m
//  CodificacionImagen
//
//  Created by Luis Alejandro Rangel Sánchez on 04/02/13.
//  Copyright (c) 2013 Vibebrand. All rights reserved.
//

#import "ImageViewController.h"

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
    UIImage *img = [[[UIImage alloc] initWithData:data scale: 1.0] autorelease];
    
    
    NSData * pictureData = UIImagePNGRepresentation(img);
    NSString * pictureDataString = [self encodeBase64: pictureData];
    
    [self.imageView setImage: img];
    [self.textArea setText: pictureDataString];
    [self.view endEditing: YES];
    
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.imageView setImage: nil];
    [self.textArea setText: @""];
    
    return YES;
}

- (NSString*)encodeBase64: (NSData * ) data {
    static char* alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    unsigned int length = data.length;
    unsigned const char* rawData = data.bytes;
    
    //empty data = empty output
    if (length == 0) {
        return @"";
    }
    
    unsigned int outputLength = (((length + 2) / 3) * 4);
    
    //let's allocate buffer for the output
    char* rawOutput = malloc(outputLength + 1);
    
    //with each step we get 3 bytes from the input and write 4 bytes to the output
    for (unsigned int i = 0, outputIndex = 0; i < length; i += 3, outputIndex += 4) {
        BOOL triple = NO;
        BOOL quad = NO;
        
        //get 3 bytes (or only 1 or 2 when we have reached the end of input)
        unsigned int value = rawData[i];
        value <<= 8;
        
        if (i + 1 < length) {
            value |= rawData[i + 1];
            triple = YES;
        }
        
        value <<= 8;
        
        if (i + 2 < length) {
            value |= rawData[i + 2];
            quad = YES;
        }
        
        //3 * 8 bits written as 4 * 6 bits (indexing the 64 chars of the alphabet)
        //write = if end of input reached
        rawOutput[outputIndex + 3] = (quad) ? alphabet[value & 0x3F] : '=';
        value >>= 6;
        rawOutput[outputIndex + 2] = (triple) ? alphabet[value & 0x3F] : '=';
        value >>= 6;
        rawOutput[outputIndex + 1] = alphabet[value & 0x3F];
        value >>= 6;
        rawOutput[outputIndex] = alphabet[value & 0x3F];
    }
    
    rawOutput[outputLength] = 0;
    
    NSString* output = [NSString stringWithCString:rawOutput encoding:NSASCIIStringEncoding];
    
    free(rawOutput);
    
    return output;
}

- (void)dealloc {
    [_urlImage release];
    [_imageView release];
    [_textArea release];
    [super dealloc];
}
@end
