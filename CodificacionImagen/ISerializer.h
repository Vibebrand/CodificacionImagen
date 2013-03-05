//
//  ISerializer.h
//  CodificacionImagen
//
//  Created by Luis Alejandro Rangel Sánchez on 04/03/13.
//  Copyright (c) 2013 Vibebrand. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISerializer <NSObject>

-(NSString *) serialize: (NSData * )data;

-(NSData *) deserialize: (NSString *) input;

@end
