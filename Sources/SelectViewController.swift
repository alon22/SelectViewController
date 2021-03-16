//
//  SelectViewController.swift
//  SelectViewController
//
//  Created by Rubén Alonso on 7/2/21.
//

import UIKit

public class SelectViewController<T>: SelectViewControllerCustom<T, SelectViewCell> {

}


public class SelectViewControllerCustom<T, U:UITableViewCell>: UIViewController,
                                                               UITableViewDataSource,
                                                               UITableViewDelegate where U: SelectCell {

    private let tableView = UITableView()
    private let stackView = UIStackView()
    private let navigationBar = UINavigationBar()
    public var items: [T]?
    public var block: ((_ cell: U, _ item: T?) -> Void)?
    public var options = SelectOptions()
    public var type: SelectType = .default
    public var delegate: SelectViewControllerDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        updateTableView()
    }

    private func setupTableView() {
        tableView.frame = self.view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)

        if U() is SelectViewCell {
            tableView.register(U.self, forCellReuseIdentifier: U.reuseId())
        } else {
            tableView.register(U.nib(), forCellReuseIdentifier: U.reuseId())
        }
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func updateTableView() {
        tableView.allowsMultipleSelection = options.multipleSelection
        tableView.reloadData()
    }

    private func setupNavigationBar() {
        title = options.title
        if isModal {
            if let closeImage = options.closeImage {
                let closeItem = UIBarButtonItem(image: closeImage,
                                                style: .plain,
                                                target: self,
                                                action: #selector(close))
                navigationItem.leftBarButtonItem = closeItem
            } else if #available(iOS 13, *) {
                let closeItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                target: self,
                                                action: #selector(close))
                navigationItem.leftBarButtonItem = closeItem
            }
        } else {
            navigationItem.leftBarButtonItem = nil
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: U.reuseId(), for: indexPath) as! U
        block?(cell, items?[indexPath.row])
        if cell.isSelected {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectViewController(didSelect: getSelected(), inType: type)
        if options.dismissAtSelection && !options.multipleSelection {
            close()
        }
    }

    @objc private func close() {
        self.delegate?.selectViewControllerWillDismiss(for: self.type)
        if isModal {
            dismiss(animated: true) {
                self.delegate?.selectViewControllerDidDismiss(for: self.type)
            }
        } else if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }

    private func getSelected() -> [T] {
        var items = [T]()
        guard let indexPaths = tableView.indexPathsForSelectedRows else {
            return items
        }
        for indexPath in indexPaths {
            if let item = self.items?[indexPath.row] {
                items.append(item)
            }
        }
        return items
    }
}
