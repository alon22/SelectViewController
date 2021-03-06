//
//  ViewController.swift
//  SelectViewController Example
//
//  Created by Rubén Alonso on 9/2/21.
//

import UIKit
import SelectViewController

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let vc = SelectViewController<ListItem>()
    var selected = [ListItem]()

    enum Cells: Int, CaseIterable {
        case one
        case multiple
        case navigation
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSelectViewController()
    }

    func setupSelectViewController() {
        vc.delegate = self
        vc.items = [
            ListItem(id: 1, name: "Test 1"),
            ListItem(id: 2, name: "Test 2"),
            ListItem(id: 3, name: "Test 3"),
            ListItem(id: 4, name: "Test 4"),
            ListItem(id: 5, name: "Test 5")
        ]
        vc.block = { cell, item in
            cell.textLabel?.text = item?.name
            guard let item = item else {
                return
            }
            cell.isSelected = self.selected.contains(item)
        }
    }

    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ID")
        tableView.dataSource = self
        tableView.delegate = self
    }

    func choseOneOption() {
        vc.options.multipleSelection = false
        vc.options.title = "Choose one option"
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }

    func chooseMultipleOptions() {
        vc.options.multipleSelection = true
        vc.options.title = ""
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }

    func pushNavigation() {
        vc.options.multipleSelection = true
        vc.options.title = "Push navigation, custom type"
        vc.type = .custom(0)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cells.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID", for: indexPath)
        let type = Cells(rawValue: indexPath.row)!
        switch type {
        case .one:
            cell.textLabel?.text = "One option"
        case .multiple:
            cell.textLabel?.text = "Multiple option"
        case .navigation:
            cell.textLabel?.text = "Push navigation, custom type"
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = Cells(rawValue: indexPath.row)!
        switch type {
        case .one:
            self.choseOneOption()
        case .multiple:
            self.chooseMultipleOptions()
        case .navigation:
            self.pushNavigation()
        }
    }
}

extension ViewController: SelectViewControllerDelegate {
    func selectViewController(didSelect items: [Any], inType: SelectType) {
        switch inType {
        case .default: break
        case .custom(let value):
            print(value)
        }
        selected = items as! [ListItem]
        print(selected, inType)
    }
}

struct ListItem: Equatable {
    var id: Int?
    var name: String?

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
