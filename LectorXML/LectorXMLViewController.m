//
//  LectorXMLViewController.m
//  LectorXML
//
//  Created by alejandro on 3/28/14.
//  Copyright (c) 2014 alejandro. All rights reserved.
//

#import "LectorXMLViewController.h"
//http://ipad.about.com/od/iPad-App-Dev/a/How-To-Parse-Xml-Files-In-Xcode-Objective-C.htm

@interface LectorXMLViewController ()

@end

@implementation LectorXMLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self parseXMLFileAtURL:@"http://www.w3schools.com/xml/plant_catalog.xml"];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"Archivo encontrado e inicia el análisis del archivo");
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identificador = @"celda";
    UITableViewCell * celda = [tableView dequeueReusableCellWithIdentifier:identificador forIndexPath:indexPath];
    celda.textLabel.text = @"Título de la celda";
    celda.detailTextLabel.text = @"Detalle";
    return celda;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)parseXMLFileAtURL:(NSString *)URL
{
    NSLog(@"Inicia el proceso de análisis del archivo");
    NSString *agentString = @"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:URL]];
    [request setValue:agentString forHTTPHeaderField:@"User-Agent"];
    NSData *xmlFile = [ NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil ];
    
    
    
    articles = [[NSMutableArray alloc] init];
    errorParsing=NO;
    
    rssParser = [[NSXMLParser alloc] initWithData:xmlFile];
    [rssParser setDelegate:self];
    
    // You may need to turn some of these on depending on the type of XML file you are parsing
    [rssParser setShouldProcessNamespaces:NO];
    [rssParser setShouldReportNamespacePrefixes:NO];
    [rssParser setShouldResolveExternalEntities:NO];
    
    [rssParser parse];
    
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    NSString *errorString = [NSString stringWithFormat:@"Error code %i", [parseError code]];
    NSLog(@"Error parsing XML: %@", errorString);
    
    
    errorParsing=YES;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    
    NSLog(@"Encontró un elemento");

    currentElement = [elementName copy];
    ElementValue = [[NSMutableString alloc] init];
    if ([elementName isEqualToString:@"breakFast_menu"]) {
        item = [[NSMutableDictionary alloc] init];
         NSLog(@"Encontró el elemento %@",elementName);
        
    }
   
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    
    NSMutableString *cadena = [NSMutableString stringWithString:string];
    NSLog(cadena, nil);
    [ElementValue appendString:string];
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    NSLog(@"Terminó el elemento");
    
    if ([elementName isEqualToString:@"breakFast_menu"]) {
        
        NSLog(@"Agregó un elemento");
        [articles addObject:[item copy]];
    } else {
        [item setObject:ElementValue forKey:elementName];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    if (errorParsing == NO)
    {
        NSLog(@"XML processing done!");
    } else {
        NSLog(@"Error occurred during XML processing");
    }
    
}




@end
