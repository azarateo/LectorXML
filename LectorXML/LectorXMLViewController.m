//
//  LectorXMLViewController.m
//  LectorXML
//
//  Created by alejandro on 3/28/14.
//  Copyright (c) 2014 alejandro. All rights reserved.
//

#import "LectorXMLViewController.h"

@interface LectorXMLViewController ()

@end

@implementation LectorXMLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

-(void)analizador:(NSXMLParser *)elanalizador ocurrioErrordeAnalisis:(NSError *)elerror{

    NSString *enunciadoDeError = [NSString stringWithFormat:@"Número de error %i", [elerror code]];
    NSLog(@"Error ejecutando el análisis del XML %@", enunciadoDeError);
    errorDeAnalisis = YES;

}


@end
