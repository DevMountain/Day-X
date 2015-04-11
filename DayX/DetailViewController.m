//
//  DetailViewController.m
//  DayX
//
//  Created by Caleb Hicks on 4/10/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "DetailViewController.h"
#import "EntryController.h"

@interface DetailViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self updateWithEntry:self.entry];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearButtonTapped:(id)sender {
    self.titleTextField.text = @"";
    self.bodyTextView.text = @"";
}

- (IBAction)saveButtonTapped:(id)sender {
    
    if (self.entry) {
        self.entry.title = self.titleTextField.text;
        self.entry.bodyText = self.bodyTextView.text;
        self.entry.timestamp = [NSDate date];
    } else {
        self.entry = [[EntryController sharedInstance] createEntryWithTitle:self.titleTextField.text bodyText:self.bodyTextView.text];
    }
}

- (void)updateWithEntry:(Entry *)entry {
    self.titleTextField.text = entry.title;
    self.bodyTextView.text = entry.bodyText;
}

#pragma mark - TextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
