//
//  LectorXMLViewController.h
//  LectorXML
//
//  Created by alejandro on 3/28/14.
//  Copyright (c) 2014 alejandro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LectorXMLViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate>{

    NSXMLParser *rssParser;
    NSMutableArray *articles;
    NSMutableDictionary *item;
    NSString *currentElement;
    NSMutableString *ElementValue;
    BOOL errorParsing;

}

 - (void)parseXMLFileAtURL:(NSString *)URL;

@end
