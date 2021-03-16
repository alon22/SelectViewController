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
    let vcCustom = SelectViewControllerCustom<ListItem, CustomCell>()
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

    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ID")
        tableView.dataSource = self
        tableView.delegate = self
    }

    func setupSelectViewController() {
        configureSelect()
        configureSelectCustom()
    }

    private func configureSelect() {
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

    private func configureSelectCustom() {
        vcCustom.delegate = self
        vcCustom.items = [
            ListItem(id: 1, name: "Test 1", note: "Note 1"),
            ListItem(id: 2, name: "Test 2", note: "Note 2"),
            ListItem(id: 3, name: "Test 3", note: "Note 3"),
            ListItem(id: 4, name: "Test 4", note: "Note 4"),
            ListItem(id: 5, name: "Test 5", note: "Note 5")
        ]
        vcCustom.block = { cell, item in
            guard let item = item else {
                return
            }
            cell.labelTitle.text = item.name
            cell.labelNote.text = item.note
            cell.isSelected = self.selected.contains(item)
        }
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
        vcCustom.options.multipleSelection = true
        vcCustom.options.title = "Push navigation, custom cell and type"
        vcCustom.type = .custom(0)
        navigationController?.pushViewController(vcCustom, animated: true)
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
    var note: String?

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
