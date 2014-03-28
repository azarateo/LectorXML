//
//  LectorXMLViewController.h
//  LectorXML
//
//  Created by alejandro on 3/28/14.
//  Copyright (c) 2014 alejandro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LectorXMLViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate>{

    NSXMLParser *analizadorXML;
    NSMutableArray *articulos;
    NSMutableDictionary *item;
    NSString *elementoActual;
    NSMutableString *valorDelElemento;
    BOOL errorDeAnalisis;

}

-(void)analizaArchivoXMLEnURL:(NSString *)URL;


@end
