//imports

import UIKit

//view controller class
class ViewController: UIViewController {
//connection of table view to storyboard
    @IBOutlet weak var tableView: UITableView!
//declare array cupboard items
    var cupboardItems = [String]()

//interface builder action
    @IBAction func onAddTapped() {
        let alert = UIAlertController(title: "Add Item to Cupboard", message: nil, preferredStyle: .alert)
        alert.addTextField { (cupboardTF) in
            cupboardTF.placeholder = "Enter Food Item"
        }
        //add to array action button on alert
        let addTo = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let cupboard = alert.textFields?.first?.text
            else {return}
            print(cupboard)
            self.add(cupboard)
        }
        //cancel action button on alert
        let cancel = UIAlertAction(title: "Cancel", style: .default){ (action) in print("cancel")
            
        }
        
        //add the actions to the alert
        alert.addAction(addTo)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func add(_ cupboard: String) {
        let index = 0
        cupboardItems.insert(cupboard, at: index)
        
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .fade)
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cupboardItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let cupboard = cupboardItems[indexPath.row]
        cell.textLabel?.text = cupboard
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        cupboardItems.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

