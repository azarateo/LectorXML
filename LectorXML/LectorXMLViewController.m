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


}


@end
