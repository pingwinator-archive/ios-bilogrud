//
//  StartViewController.m
//  Reader
//
//  Created by Natasha on 12.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "StartViewController.h"
#import "FB2ViewController.h"
#import "DocumentModel.h"
#import "HTMLViewController.h"
#import "PDFViewController.h"

#define navButtonSideiPhone 70.0f
#define navButtonSideiPad 90.0f

@interface StartViewController ()

@property (nonatomic, strong) FB2ViewController* fb2ViewController;
@property (nonatomic, strong) HTMLViewController* htmlViewController;
@property (nonatomic, strong) PDFViewController* pdfViewController;
@property (nonatomic, strong) DocumentModel* documentModel;

@end

@implementation StartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton* customNextButton = [self buttonWithImage:[UIImage imageNamed:@"Setting.png"] andAction:@selector(showSetting)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customNextButton];
    self.navigationItem.title = @"Your books";
    [self.navigationController.navigationBar setBackgroundColor:[UIColor lightGrayColor]];

    if (!self.documentModel) {
        self.documentModel = [[DocumentModel alloc] init];
    }
    self.docWatcher = [DirectoryWatcher watchFolderWithPath:[self applicationDocumentsDirectory] delegate:self];
    self.documentURLs = [NSMutableArray array];
    // scan for existing documents
    [self directoryDidChange:self.docWatcher];
}

#pragma mark - Private Methods

- (UIButton*)buttonWithImage:(UIImage*)image andAction:(SEL)action
{
    UIButton* customNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customNextButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [customNextButton setImage:image forState:UIControlStateNormal];
    [customNextButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    customNextButton.frame = CGRectMake(5, 0, 30, 30.0);
    return customNextButton;
}

- (void)showSetting
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Setting" message:@"Availability download books and show all bookmarks see later" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (NSString *)formattedFileSize:(unsigned long long)size
{
	NSString *formattedStr = nil;
    if (size == 0)
		formattedStr = @"Empty";
	else
		if (size > 0 && size < 1024)
			formattedStr = [NSString stringWithFormat:@"%qu bytes", size];
        else
            if (size >= 1024 && size < pow(1024, 2))
                formattedStr = [NSString stringWithFormat:@"%.1f KB", (size / 1024.)];
            else
                if (size >= pow(1024, 2) && size < pow(1024, 3))
                    formattedStr = [NSString stringWithFormat:@"%.2f MB", (size / pow(1024, 2))];
                else
                    if (size >= pow(1024, 3))
                        formattedStr = [NSString stringWithFormat:@"%.3f GB", (size / pow(1024, 3))];
	
	return formattedStr;
}

- (void)setupDocumentControllerWithURL:(NSURL *)url
{
    if (self.docInteractionController == nil)
    {
        self.docInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        self.docInteractionController.delegate = self;
    }
    else
    {
        self.docInteractionController.URL = url;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.documentURLs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSURL *fileURL;
    fileURL = [self.documentURLs objectAtIndex:indexPath.row];
	[self setupDocumentControllerWithURL:fileURL];
	
    // layout the cell
    cell.textLabel.text = [[[fileURL path] lastPathComponent] stringByDeletingPathExtension];
    NSInteger iconCount = [self.docInteractionController.icons count];
//    if (iconCount > 0)
//    {
//        cell.imageView.image = [self.docInteractionController.icons objectAtIndex:iconCount - 1];
//    }
    
    NSError *error;
    NSString *fileURLString = [self.docInteractionController.URL path];
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:fileURLString error:&error];
    NSInteger fileSize = [[fileAttributes objectForKey:NSFileSize] intValue];
    
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",
//                                 [self formattedFileSize:fileSize], self.docInteractionController.UTI];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",
                                 [self formattedFileSize:fileSize]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *fileUrl = [self.documentURLs objectAtIndex:indexPath.row];
    self.documentModel.documentLastPage = 1;
    self.documentModel.documentUrl = fileUrl;
    NSLog(@"file extension %@", [fileUrl pathExtension]);
    if ([[fileUrl pathExtension] isEqualToString: @"pdf"]) {
        self.documentModel.documentType = DocumentType_PDF;
        self.pdfViewController = [[PDFViewController alloc] initWithDocument:self.documentModel];
        [self.navigationController pushViewController:self.pdfViewController animated:YES];
    }
    
    if ([[fileUrl pathExtension] isEqualToString: @"fb2"]) {
        self.documentModel.documentType = DocumentType_fb2;
        self.fb2ViewController = [[FB2ViewController alloc] initWithDocument:self.documentModel];
        [self.navigationController pushViewController:self.fb2ViewController animated:YES];
    }
    if ([[fileUrl pathExtension] isEqualToString: @"html"]) {
        self.documentModel.documentType = DocumentType_HTML;
        self.htmlViewController = [[HTMLViewController alloc] initWithDocument:self.documentModel];
        [self.navigationController pushViewController:self.htmlViewController animated:YES];
    }
}

#pragma mark -
#pragma mark File system support

- (NSString *)applicationDocumentsDirectory
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)directoryDidChange:(DirectoryWatcher *)folderWatcher
{
	[self.documentURLs removeAllObjects];    // clear out the old docs and start over
	
	NSString *documentsDirectoryPath = [self applicationDocumentsDirectory];
	
	NSArray *documentsDirectoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectoryPath error:NULL];
    
	for (NSString* curFileName in [documentsDirectoryContents objectEnumerator])
	{
		NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:curFileName];
		NSURL *fileURL = [NSURL fileURLWithPath:filePath];
		
		BOOL isDirectory;
        [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
		
        // proceed to add the document URL to our list (ignore the "Inbox" folder)
        if (!(isDirectory && [curFileName isEqualToString: @"Inbox"]))
        {
            [self.documentURLs addObject:fileURL];
        }
	}
	[self.tableView reloadData];
}

@end
