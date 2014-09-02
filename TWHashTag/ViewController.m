//
//  ViewController.m
//  TWHashTag
//
//  Created by Gil Beyruth on 9/1/14.
//  Copyright (c) 2014 Gil Beyruth. All rights reserved.
//

#import "ViewController.h"
#import "STTwitter.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

    @property (weak, nonatomic) IBOutlet UITableView *twitterTableView;
    @property (strong, nonatomic) NSMutableArray *twitterFeed;

@end

@implementation ViewController

@synthesize twitterFeed;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    STTwitterAPI* twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"iqUxUUKT4GnEpKZqdZhrlOEct" consumerSecret:@"UebKOVbYPf7Zm4NaMUaK8fLsEeuLk5gIfUyQk27JzvmEb9AIav"];
    
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
        [twitter getSearchTweetsWithQuery:@"%23vagas" successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
            self.twitterFeed = [NSMutableArray arrayWithArray:statuses];
            [self.twitterTableView reloadData];
        } errorBlock:^(NSError *error) {
            NSLog(@"Search Error :%@", error);
        }];
    } errorBlock:^(NSError *error) {
        NSLog(@"Credential Error :%@", error);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.twitterFeed.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        
    }
    
    NSInteger index = indexPath.row;
    NSDictionary *t = self.twitterFeed[index];
    cell.textLabel.text = t[@"text"];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
