# iOSAssignment
Application displays a few facts about canada.

## Swift Language Version Used:
Swift 4.0

## Xcode Version
Xcode 9.2

## Getting Started
Implemented the complete functionality.
1. Created an appropraite architecture heirarchy.
2. Followed MVVM, Furthermore, extracted View Controller Datasource from ViewController.
2. Each module serves their own role and can be tested accordingly.
3. Added appropriate cocoa pods.

## Reusable:
Added appropriate extension for UITableViewCells reusability.
The cleanest solution i have come up to dequeue the cells.

## Pods Used :
SwiftJSON - To parse JSON response in a clean way.
NVActivityIndicatorView - A nice loading animation.
Kingfisher - To download / cache image asynchronously.
Snapkit - Used to add Layout Constraints.
However as per the requirements, the data cell uses Visual Format Language to layout the constraints.

## API Used:
https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json

## No Xib & Storyboards
The app doesnt contain any storyboards or xib files.

## Unit Tests
Added a few unit test cases.
