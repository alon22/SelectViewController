# SelectViewController

Simple items selection control

## Installation
### CocoaPods

Add

    pod 'SelectViewController'

to your podfile and run

    pod install

to install the framework.

## Usage
### Basic
```swift
struct ListItem: Equatable {
    var id: Int?
    var name: String?

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
```
```swift
let selectViewController = SelectViewController<ListItem>()
selectViewController.delegate = self
selectViewController.items = [
    ListItem(id: 1, name: "Test 1"),
    ListItem(id: 2, name: "Test 2"),
    ListItem(id: 3, name: "Test 3"),
    ListItem(id: 4, name: "Test 4"),
    ListItem(id: 5, name: "Test 5")
]
selectViewController.block = { cell, item in
    cell.textLabel?.text = item?.name
    guard let item = item else {
        return
    }
    cell.isSelected = self.selected.contains(item)
}
```
```swift
extension ViewController: SelectViewControllerDelegate {
    func selectViewController(didSelect items: [Any], inType: SelectType) {
        selected = items as! [ListItem]
    }
}
```
### Options
`multipleSelection`: Allow multiple selection. Default `false`

`dismissAtSelection`: Dismiss or pop after selection. Only if `multipleSelection` equal to `false`. Default `false`

`closeImage`: UIImage for UIBarButtonItem to dismiss. Default for iOS 13 or higher `barButtonSystemItem: .close`, other `nil`

`title`: Title to show in navigation bar. Default `nil`

### Multiple SelectViewController
If you have multiple SelectViewController in same ViewController, use custom type to differentiate selected items
```swift
selectViewController.type = .custom(0)
```
```swift
extension ViewController: SelectViewControllerDelegate {
    func selectViewController(didSelect items: [Any], inType: SelectType) {
        switch inType {
        case .default: break
        case .custom(let value):
            switch value {
            case 0:
                selected = items as! [ListItem]
            default: break
            }
        }
    }
}
```
