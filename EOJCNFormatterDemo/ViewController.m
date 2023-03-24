//
//  ViewController.m
//  EOJCNFormatterDemo
//
//  Created by Joe on 2023-03-24.
//

#import "ViewController.h"
#import <EOJCNFormatter/EOJCNFormatter.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"50104"];
    NSLog(@"%s. result: %@", __PRETTY_FUNCTION__, result);
}


@end
