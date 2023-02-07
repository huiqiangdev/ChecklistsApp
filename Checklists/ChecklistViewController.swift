//
//  ViewController.swift
//  Checklists
//
//  Created by HQ on 2023/2/6.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
  
  
  var items = [ChecklistItem]()


  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
    
    
    // Do any additional setup after loading the view.
    for  index in 0...5 {
      let item = ChecklistItem()
      item.text = "index-\(index)"
      item.checked = index % 2 == 0
      items.append(item)
    }
  }
  
  //MARK: - Table View Data Source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    
    let item = items[indexPath.row]
    
    configureText(for: cell, with: item)
    
    configureCheckmark(for: cell, with: item)
    
    return cell
  }
  
  //MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      
      let item = items[indexPath.row]
      
      item.toggleChecked()
      
      configureCheckmark(for: cell, with: item)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    // 1.
    items.remove(at: indexPath.item)
    
    // 2.
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  

  
  //MARK: - Add Item ViewController Delegates
  func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
      navigationController?.popViewController(animated:true)
  }
  
  func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
      let newRowIndex = items.count
      items.append(item)
      
      let indexPath = IndexPath(row: newRowIndex, section: 0)
      let indexPaths = [indexPath]
      tableView.insertRows(at: indexPaths, with: .automatic)
      navigationController?.popViewController(animated:true)
  }
  //MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue,
                        sender: Any?) {
    // 1
    if segue.identifier == "AddItem" {
      // 2
      let controller = segue.destination
      as! AddItemViewController
      // 3
      controller.delegate = self
    }
  }


}

extension ChecklistViewController {
  func configureText(for cell:UITableViewCell, with item: ChecklistItem) {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
  }
  
  func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
    cell.accessoryType = item.checked ? .checkmark : .none
  }
}
