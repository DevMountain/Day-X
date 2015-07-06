# Day-X Outline

Day-X is a simple journaling iOS app that we use to demonstrate many concepts we cover in class.

## Lesson 6 - Storyboard, list view, detail view

In this section we will add a ```ListViewController``` that will display our list of journal entries. We will add a ```DetailViewController``` that will display and edit journal entries. We will set up our Storyboard scenes and wire them up to each of the views. 

### Set Up the ListViewController

#### Preparation
- Rename ```ViewController``` to ```ListViewController``` using the Refactor tool
- Add an external datasource class ```ListTableViewDataSource``` as an NSObject sublcass

#### Storyboard Scene
- Embed the ```ListViewController`` into a ```UINavigationController```
- Set the title of the ```ListViewController```
- Add a TableView to the ```ListViewController``` scene and set suggested constraints
- Add one 'prototype cell' to the TableView and assign 'entryCell' as the reuse identifier
- Add an ```NSObject``` to the ```ListViewController``` scene
- Use the Identity Inspector to set the Object to a ```ListTableViewDataSource``` class
- Wire up the scene's TableView to the ```ListTableViewDataSource``` object as a datasource outlet
- Add a Bar Button Item and use the Attribute Inspector to set the Identifier to `Add`

#### Class Implementation
- Import ```UIKit``` into the ```ListTableViewDataSource``` and adopt the ```UITableViewDataSource``` protocol
- Add the required datasource methods in the implementation file
- Dequeue the cell with the reuse identifier we set in the Storyboard scene
- Set the cell's textLabel to 'Entry X' where X is equal to the row the cell occupies (hint: ```[NSString stringWithFormat:]```)
- Eventually the app will return the specific number of entries we have, for now, return 5 cells

Run the app. You should have a TableView with 5 cells.

### Set Up the DetailViewController

- Add a new ```DetailViewController``` class to the project
- Add a new ViewController Scene to the Storyboard
- Use the Identity Inspector to set the scene to the ```DetailViewController``` class
- Add a 'show' segue from the Add button to the ```DetailViewController``` and give the segue an identifier 'addEntry'
- Add a 'show' segue from the TableViewCell to the ```DetailViewController``` and give the segue an identifer 'viewEntry'

Run the app. Your cells and the Add button should push the ```DetailViewController```.

#### Add a text field to the view controller

- Add a UITextField to the top of the view controller in your XIB
- Add an IBOutlet UITextField property to the interface in the implementation file
- Wire up the UITextField 'referencing outlet' to the 'textField' outlet on the view controller
- Wire up the UITextField to the DetailViewController as the delegate
- Add the textFieldShouldReturn method to the class
- In the method, have the textField resign first responder

Run the app. Your keyboard should be dismissed when you hit Enter.

#### Add a text view to the view controller

- Add an IBOutlet UITextView property to the interface in the implementation file
- Add a UITextView just under the title field the view controller in your XIB
- Wire up the UITextView 'referencing outlet' to the 'textView' outlet on the view controller

#### Add a clear button to the view controller

- Add a UIButton just below the body text view in the Storyboard scene
- Add an IBAction method called 'clearButtonTapped' to your implementation file
- Wire up the UIButton 'TouchUpInside' control event to your action
- In the action set the title field and text view's content to empty strings

Run the app. You should now be able to clear the TextField and TextView when you tap the clear button.

## Lesson 7 - Model Objects and Model Object Controllers

In this section we will add an ```Entry``` class. We will add an ```EntryController``` class that will help us manage our Entries in one location. We will set our TableView to display Entries instead of static data, and we will set up our ```DetailViewController``` to update with the Entry it displays.

An Object Controller should be the source of valid data for the entire app. In this case we will create an ```EntryController``` to manage our ```Entry``` objects and to handle communication between the view controllers. The ```EntryController``` will be a shared instance with an NSArray property that holds all of the entries the app has saved. Eventually, we will add persistence to the app using the ```EntryController```.  

#### Add an Entry class

- Create an Entry subclass (of NSObject) with public properties:
    * ```title``` (NSString* strong)
    * ```bodyText``` (NSString* strong)
    * ```timestamp``` (NSDate* strong)

#### Add an EntryController class

- Create an EntryController subclass (of NSObject) with property:
    * ```entries``` (NSArray, strong, nonatomic readonly) in the Header file
    * ```entries``` (NSArray, strong, nonatomic) in the Implementation file

We have a public and private implementation of ```entries``` because we want to make the array public, but not give write access outside of the EntryController class. The private implementation allows the class to update the array internally.

- Add the following public methods:
    * ```+ (EntryController *)sharedInstance```
    * ```- (void)addEntry:(Entry *)entry```
    * ```- (void)removeEntry:(Entry *)entry```

The shared instance method should be defined as follows:

```
+ (EntryController *)sharedInstance {
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [EntryController new];

        sharedInstance.entries = [NSArray new];
    });
    return sharedInstance;
}
```

- Implement the addEntry method: it needs to create a mutable version of the controller's entries array, add the entry that's passed in, and then re-set the controller's Entries array.

- Implement the removeEntry method: it needs to do the reverse. It should create a mutable copy of the entries array, remove the entry that was passed in, and then re-set the controllers Entries array.

#### Update the DetailViewController to save entries

- Add a public property:
    * ```entry``` (Entry, strong, nonatomic)

We will use this Entry property to set the specific entry that the view controller is editing.

- Add a Navigation Item to the Storyboard scene for the ```DetailViewController```, remove the 'Title' text from the navigation bar if it appears
- Add a Bar Button Item to the navigation bar with the Save identifier
- Wire up an IBAction method to the ```DetailViewController``` called 'saveButtonTapped'
- Implement the saveButtonTapped method: it needs to call the createEntry method on the EntryController and pass the correct parameters (you'll need to import the ```EntryController``` class), and optionally dismiss the ```DetailViewController``` once completed
- Set self.entry to the result of the ```createEntry``` method (remember, the createEntry method returns the created Entry object)

#### Update the ListViewController datasource to display saved entries

- Import the EntryController class to the ListTableViewDataSource
- Update ```numberOfRowsInSection``` to use the count of objects in the ```[EntryController sharedInstance]``` entries array
- Update ```cellForRowAtIndexPath``` to set the label to the title of the Entry, use the ```[EntryController sharedInstance]``` entries array and the indexPath.row to update the label with the correct Entry

#### Update the ListViewController to reload the TableView each time it appears

- Add an IBOutlet from your TableView to your ListViewController's private implementation
- Add a ```viewWillAppear``` ViewController lifecycle method to the ```ListViewController```
- Reload the TableView in the ```viewWillAppear``` method

#### Update the ListViewController to update the DetailViewController Correctly

We will implement a common design pattern to pass data to a detail view controller and update the detail view accordingly. Practice this and understand why we do each line.

- Add a ```prepareForSegue:``` method to the ListViewController
- Check the identifier of the segue parameter, if the identifier is 'addEntry' then we will not pass an entry, if the identifier is 'viewEntry' we will pass the selected entry to the ```DetailViewController``` (you will need to import the ```DetailViewController``` and the ```EntryController```, and get the IndexPath of the selected cell)

- Add an ```updateWithEntry:``` method to the DetailViewController: it needs to update the view's TextField and TextView with the text from the entry passed into it
- In the ```viewDidLoad``` method, run the updateWithEntry method with self.entry

Run the app. You should now have a TableView that displays the correct number of entries based created during the app launch.  Saving an entry on the DetailTextView should now add that entry to the list. Try pushing the Save button multiple times. This will create a new entry each time. Let's fix it.

When we add a new entry, we want to create a new one. When we edit an entry, we want to update that specific entry in memory.

- In the ```saveButtonTapped:``` method, add a check to see if self.entry exists. If so, update the entry's properties in place. If not, create a new entry.

## Lesson 8 - NSDictionaries and NSUserDefaults

In this section we will add data persistence to our app by adding functionality to our EntryController class. We will convert our Entry model objects into dictionaries, save them to NSUserDefaults, and add the ability to retrieve those dictionaries from NSUserDefaults and convert them back into Entry model objects for our app to use.

### Saving Data to NSUserDefaults

Remember that NSUserDefaults cannot store custom model objects. We will need to convert our Entry model objects to NSDictionaries to save them to NSUserDefaults. When we launch our app again, we will need pull the NSDictionaries out of NSUserDefaults and convert them into our Entry model objects for use in the app.

This can seem unintuitive and frustrating for a beginner programmer. But this conversion process is a skill you will need to have any time you work with NSUserDefaults, writing to disk, or working with web services. 

We will do this using what we call 'builder methods'. Builder methods convert from one object type to another object type, in this case, from an Entry to an NSDictionary or an NSDictionary to an Entry.

#### Add the builder methods to the Entry Class

- Add a new custom init method to the Entry class called ```initWithDictionary:```
- Implement the ```initWithDictionary``` method: it needs to take an NSDictionary as a parameter and set the self.title, self.bodyText, and self.timestamp from the values in the NSDictionary

- Add a new instance method to the Entry class called ```dictionaryRepresentation```
- Implement the ```dictionaryRepresentation``` method: it needs to take the self.title, self.bodyText, and self.timestamp and set those values to keys in an NSDictionary, then return the NSDictionary you created

Hint: Use constant strings to make sure that your keys are consistent. Your data will not load correctly if your dictionary keys are not identical in both the ```initWithDictionary:``` method and the ```dictionaryRepresentation``` methods.

#### Update the EntryController class to add functionality to save all Entry objects to NSUserDefaults

- Add a new method to the EntryController named ```saveToPersistentStorage```
- Implement the ```saveToPersistentStorage``` method: it needs to iterate through the self.entries array, create an NSDictionary representation of each Entry, add it to a temporary NSMutableArray, and save that NSMutableArray to NSUserDefaults using an 'AllEntriesKey'
- Add the ```saveToPersistentStorage``` method to each method that updates the self.entries array so that all changes are persisted to NSUserDefaults

In earlier steps we update Entry objects directly in memory, which was sufficient to update our ListViewController and DetailViewController with the correct data. However, our current implementation does not persist those changes because our ```saveToPersistentStorage``` method is only called when we add or remove an entry. Let's fix this by creating a public ```save``` method that gets called when we update Entry objects. 

We add this extra method to provide a better public name than 'saveToPersistentStorage' to other classes, alternatively you could make the ```saveToPersistentStorage``` method public and accomplish the same task.

- Add a new public method to the EntryController named ```save```
- Implement the ```save``` method: it needs to call the ```saveToPersistentStorage```, 
- Add the ```save``` method to the DetailViewController ```saveButtonTapped:``` IBAction method

#### Update the EntryController class to add functionality to load all Entry objects from NSUserDefaults

- Add a new method to the EntryController named ```loadFromPersistentStorage```
- Implement the ```loadFromPersistentStorage```: it needs to load the array of NSDictionaries from NSUserDefaults using the `AllEntriesKey`, iterate through the array, initialize an Entry for each NSDictionary and add it to a NSMutableArray, and set self.entries to that NSMutableArray
- In the sharedInstance method, replace the code that sets the ```sharedInstance.entries``` to an empty array with the ```loadFromPersistentStorage``` method

Run the app. You should now be able to create new entries, edit existing entries, and load saved entries when you relaunch the app.

## Lesson - Core Data

In this section we will replace NSUserDefaults for data persistence with Core Data. Because of the way we have written the app, most of the changes we make will be in the ```EntryController``` class. We will add the Core Data framework to the project, add a Core Data Model file, replace our Entry NSObject subclass with a NSManagedObject subclass, and update our ```EntryController``` to save to and load from Core Data's persistent store.

#### Core Data Setup

- Add the Core Data framework as a linked library in your project. Click on your DayX target, click the + button for Linked Frameworks and Libraries, and add CoreData.framework
- Add a new Model file. File, New, File, Core Data, Data Model. You can name it what you'd like, but remember what you name it because we'll need that information later. The solution uses 'Model'.
- Create your ```Entry``` entity in the Model with attributes:
    * ```title``` (NSString)
    * ```bodyText``` (NSString)
    * ```timestamp``` (NSDate)
- Delete your current Entry.h and Entry.m files, we will replace them with the NSManagedObject subclass
- Create your NSManagedObject subclass by clicking Editor, Create NSManagedObject Subclass and navigating through the menus to create the new Entry.h and Entry.m files

- Import the ```Stack``` class from the solution or from [gist](https://gist.github.com/jkhowland/6ba5accdb4b8d5d98af0)

#### Update the EntryController

- Remove the implementation code from the following methods:
    * ```saveToPersistentStore:```
    * ```removeEntry:```

- Remove the following properties and methods, and remove references to them:
    * ```loadFromPersistentStorage```
    * ```entries``` (private only, leave the public)

##### Adding Entry Objects to Core Data

- Reimplement ```createEntryWithTitle: bodyText:``` method: it needs to use the ```insertNewObjectForEntityForName:``` on ```NSEntityDescription``` instead of [Entry new]
- We no longer need to use the ```addEntry``` method. Instead we want to save directly to the persistent store. Use the ```saveToPersistentStorage``` method to save our new entry.

- Reimplement ```saveToPersistentStorage```: it needs to save the ```managedObjectContext``` on the ```Stack``` class.

- Reimplement ```removeEntry:```: it needs to delete the entry object from the entry's Managed Object Context.

#### Pulling Entry Objects from Core Data

- Implement ```entries``` as a custom getter method for the public, read-only entries property: it needs to instantiate and execute a fetch request for ```Entry``` entities from the ```managedObjectContext``` on the ```Stack``` class.

Run the app. Your entries saved to NSUserDefaults should no longer appear. When you create an Entry, it should save to Core Data and display in your list of entries. When you reload your app, your entries should display in the list.

#### The Beauty of MVC

Take note that we were able to update our entire model by updating the ```EntryController``` class. We were able to do this because of well-defined, specific roles that we assigned to each class.
