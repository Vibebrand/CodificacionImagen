//
//  Serializer.m
//  CodificacionImagen
//
//  Created by Luis Alejandro Rangel Sánchez on 04/03/13.
//  Copyright (c) 2013 Vibebrand. All rights reserved.
//

#import "Serializer.h"
#import "GTMBase64.h"

@implementation Serializer

-(NSString *) serialize: (NSData *) data {
    
    return [GTMBase64 stringByEncodingData:data];
}

/**
 * Deserialize Base64 NSString to NSData
 */
-(NSData *) deserialize: (NSString *) input {
    
    return [GTMBase64 decodeString: input];
    
}

@end
