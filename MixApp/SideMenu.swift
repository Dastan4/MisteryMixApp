//
//  SideMenu.swift
//  MixApp
//
//  Created by Dastan Mambetaliev on 21/2/21.
//

import Foundation
import UIKit

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: String)
}

class MenuController: UITableViewController {
    
    public var delegate: MenuControllerDelegate?
    
    private let menuItems: [String]
    init(with menuItems: [String]) {
        self.menuItems = menuItems
//        ???
        super.init(nibName: nil, bundle: nil)
//        ???
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
//    ???
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //изменение цвета background при нажатии на меню
        tableView.backgroundColor = .darkGray
        view.backgroundColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    }
    
//    Table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
//изменение цвета текста в ячейках и заднего фона
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray
        cell.contentView.backgroundColor = .darkGray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//мы должны выбрать неоходимый нам элемент из меню, потом закрыть его и показать нам другой выбранный нами controller ИСПОЛЬЗУЕТСЯ delegate который мы прописали выше
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
    }
    
}
