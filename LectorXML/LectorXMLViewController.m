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
    [self analizaArchivoXMLEnURL:@"poi.colombiajoven.gov.co/api/oferta"];
}

-(void)analizadorInicioDocumento:(NSXMLParser *)analizador
{
    NSLog(@"Archivo encontrado y análisis iniciado");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)analizaArchivoXMLEnURL:(NSString *)URL{

    NSString *agentString = @"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:URL]];
    [request setValue:agentString forHTTPHeaderField:@"User-Agent"];
    NSData *archivoXML = [ NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil ];
    
    
    articulos = [[NSMutableArray alloc] init];
    errorDeAnalisis=NO;
    
    analizadorXML = [[NSXMLParser alloc] initWithData:archivoXML];
    [analizadorXML setDelegate:self];
    
    // You may need to turn some of these on depending on the type of XML file you are parsing
    [analizadorXML setShouldProcessNamespaces:NO];
    [analizadorXML setShouldReportNamespacePrefixes:NO];
    [analizadorXML setShouldResolveExternalEntities:NO];
    [analizadorXML parse];
    

}

-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{

    NSString *enunciadoDeError = [NSString stringWithFormat:@"Número de error %i", [parseError code]];
    NSLog(@"Error ejecutando el análisis del XML %@", enunciadoDeError);
    errorDeAnalisis = YES;

}


-(void)     parser:(NSXMLParser *)parser
   didStartElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qName
        attributes:(NSDictionary *)attributeDict{
    
    elementoActual = [elementName copy];
    valorDelElemento = [[NSMutableString alloc] init];
    if([elementName isEqualToString:@"Oportunidad"]){
        item = [[NSMutableDictionary alloc] init];
    }

}

-(void)     parser:(NSXMLParser *)parser
   foundCharacters:(NSString *)string{

    [valorDelElemento appendString:string];
    
}


-(void)     parser:(NSXMLParser *)parser
     didEndElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qName{
    
    
    NSLog(@"Nombre del elemento %@",elementName);
     NSLog(@"Nombre del elemento %@",namespaceURI);
     NSLog(@"Nombre del elemento %@",qName);
    

    if([elementName isEqualToString:@"Oportunidad"]){
        [articulos addObject:[item copy]];
    }else {
        [item setObject:valorDelElemento forKey:elementName];
    }

}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    if (errorDeAnalisis == NO)
    {
        NSLog(@"Procesamiento de XML terminado");
    } else {
        NSLog(@"Comenzó error durante el análisis");
    }
    
}


@end
