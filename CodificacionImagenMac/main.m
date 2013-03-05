//
//  main.m
//  CodificacionImagenMac
//
//  Created by Luis Alejandro Rangel Sánchez on 04/03/13.
//  Copyright (c) 2013 Vibebrand. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "../CodificacionImagen/Serializer.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Serializer * serializer = [[Serializer new] autorelease];
        
        if (argc > 1) {
            NSString * filePath = [NSString stringWithFormat: @"%s", argv[1]];
            NSString * destFilePath = [filePath stringByAppendingString: @".base64"];
            NSString * destFilePathHeader = [[filePath stringByDeletingPathExtension] stringByAppendingPathExtension: @"h"];
            
            NSURL *url = [[[NSURL alloc] initFileURLWithPath: filePath isDirectory:NO] autorelease];
            NSData *data = [NSData dataWithContentsOfURL: url];
            NSString * res = [serializer serialize: data];
            
            
            // Base64
            NSError * error = nil;
            [res writeToFile: destFilePath  atomically: NO encoding:NSUTF8StringEncoding error: &error];
            
            // Header
            NSString * lastPathComponent = [[filePath lastPathComponent] stringByDeletingPathExtension];
            NSString * resHeader = [NSString stringWithFormat:@"#ifndef %@_H\n#define %@_H\n#define %@ @\"%@\"\n#endif\n", lastPathComponent, lastPathComponent, lastPathComponent, res];
            [resHeader writeToFile: destFilePathHeader  atomically: NO encoding:NSUTF8StringEncoding error: &error];
            NSLog(@"%@", res);
        }
    }
    return 0;
}

