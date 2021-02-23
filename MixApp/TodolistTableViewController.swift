//
//  TodolistTableViewController.swift
//  MixApp
//
//  Created by Dastan Mambetaliev on 21/2/21.
//

import UIKit

class TodolistTableViewController: UITableViewController {

    var todoList = TodoList()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
            
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//создает ячейку по идентификатору TableViewCell в main.storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItemCell", for: indexPath)
        let item = todoList.todos[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = todoList.todos[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
            todoList.updateData()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todoList.todos.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic )
        todoList.updateData()
    }
    
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        if let label1 = cell.viewWithTag(1000) as? UILabel, let label2 = cell.viewWithTag(2000) as? UILabel {
            label1.text = item.text
            label2.text = item.desc
        }
    }
    
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        guard let checkmark = cell.viewWithTag(1001) as? UILabel else {
            return
        }
        
        if item.checked {
            checkmark.text = "√"
        } else {
            checkmark.text = ""
        }
        
    }
    
//    делегирование
//с помощью метода prepare мы подготовляиваем отправку значений и принимаем готовые
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let itemDetailViewController = segue.destination as? ItemDetailViewController {
                itemDetailViewController.delegate = self
                itemDetailViewController.todoList = todoList
            }
        } else if segue.identifier == "EditItemSegue" {
            if let itemDetailViewController = segue.destination as? ItemDetailViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let item = todoList.todos[indexPath.row]
//              принимает данные с ItemDetailViewController при помощи делегирования (готовых методов которые мы прописали)
                    itemDetailViewController.delegate = self
//              отправляет данные в ItemDetailViewController
                    itemDetailViewController.itemToEdit = item
                    
                }
            }
        }
    }
}
//расширением мы передаем протокол делегирования из AddItemTableViewController
extension TodolistTableViewController: ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
//
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = todoList.todos.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
//        отправляем данные ячейки для изменения и последующего возвращения
//в массиве todoList мы ищем первый элемент который равен нашему выбранному объекту (todoList)
        if let index = todoList.todos.firstIndex(of: item) {
//         IndexPath   нумерация ячейки
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
                todoList.updateData()
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
}
