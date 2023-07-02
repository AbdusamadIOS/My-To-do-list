//
//  MainVC.swift
//  blur_View
//
//  Created by Abdusamad Mamasoliyev on 01/05/23.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tasks: [Task] = [
        Task(title: "Choyxonaga borish", description: "Sinfdoshlar bilan suhbat qilish", color: . red, viewColor: UIColor.systemGray6),
    ]
    
//    let tasksFileAddress = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathExtension("Tasks.plist")
    
    var finishadTasks: [Task] = []
    var archivedTasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "MainVCCell", bundle: nil), forCellReuseIdentifier: "MainVCCell")
        
        
        setupNavBar()
    }
    
    func setupNavBar() {
        
        navigationItem.title = "My To-Do List"

        // custom korinish yasab olish
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        
        // rang berish
        navigationBarAppearance.backgroundColor = .systemGreen
        // titleni sozlash
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)]
        
        // yasab olingan korinishni hozirgi navigation ga berish
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        
        //
    }
    
    @IBAction func blurBtn(_ sender: UIButton) {
        
        
         
        let vc = AddTextVC(nibName: "AddTextVC", bundle: nil)
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.closure = { task in
            self.tasks.append(task)
            self.tableView.reloadData()
        }
        
        self.present(vc, animated: true)
        
    }
    
    
}
extension MainVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return tasks.count
        case 1:
            return finishadTasks.count
        default:
            return archivedTasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainVCCell") as! MainVCCell
            
            cell.titleLbl.text = tasks[indexPath.row].title
            cell.desLbl.text = tasks [indexPath.row].description
            cell.cellColor.backgroundColor = tasks[indexPath.row].color
            cell.containerView.backgroundColor = UIColor.systemGray6
            
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainVCCell") as! MainVCCell
            
            cell.titleLbl.text = finishadTasks[indexPath.row].title
            cell.desLbl.text = finishadTasks[indexPath.row].description
            cell.cellColor.backgroundColor = finishadTasks[indexPath.row].color
            cell.containerView.backgroundColor = UIColor.systemGray5
            
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainVCCell") as! MainVCCell
            
            cell.titleLbl.text = archivedTasks[indexPath.row].title
            cell.desLbl.text = archivedTasks[indexPath.row].description
            cell.cellColor.backgroundColor = archivedTasks[indexPath.row].color
            cell.containerView.backgroundColor = UIColor.systemGray4
            
            cell.selectionStyle = .none
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
        
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        UIContextMenuConfiguration(identifier: nil,
                                   previewProvider: nil) { _ in
            
            
            let delete = UIAction(title: "O'chirish",image: UIImage(systemName: "trash")?.withTintColor(.red , renderingMode: .alwaysOriginal)) { _ in
                print("delete")
                
                self.tasks.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
            
            let finish = UIAction(title: "Finish task", image: UIImage(systemName: "checkmark.circle")?.withTintColor(.green, renderingMode: .alwaysOriginal)) { _ in
                
            }
            return UIMenu(children: [finish, delete])
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let deleteAction = UIContextualAction(style: .normal, title: "O'chirish") { _,_,_ in
            
            switch indexPath.section {
            case 0:
                self.tasks.remove(at: indexPath.row)
            case 1:
                self.finishadTasks.remove(at: indexPath.row)
            default:
                self.archivedTasks.remove(at: indexPath.row)
            }
            self.tableView.reloadData()
        }
        
        deleteAction.backgroundColor = UIColor.red
        
        let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipe
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let label = UILabel(frame: CGRect(x: (tableView.frame.width / 2) - 95,
                                          y: 10,
                                          width: 190,
                                          height: 40))
        label.textAlignment = .center
        label.textColor = .systemGreen

        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
        
        switch section {
        case 0:
            label.text = "New Tasks"
        case 1:
            label.text = "Finished Tasks"
        default:
            label.text = "Archived Tasks"
        }
        
        let view = UIView()
        view.addSubview(label)
        
        switch section {
        case 0:
            if tasks.count == 0 {
                return nil
            }
        case 1:
            if finishadTasks.count == 0 {
                return nil
            }
        default:
            if archivedTasks.count == 0 {
                return nil
            }
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            if tasks.count == 0 {
                return 0.000000000001
            }
        case 1:
            if finishadTasks.count == 0 {
                return 0.000000000001
            }
        default:
            if archivedTasks.count == 0 {
                return 0.000000000001
            }
        }
        
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            let alert = UIAlertController(title: "New Taskdagi taskni ozgartirish", message: nil, preferredStyle: .actionSheet)
            
            let finish = UIAlertAction(title: "Finish", style: .default) { [self] _ in
                
                let finished = tasks.remove(at: indexPath.row)
                finishadTasks.append(finished)
                
                tableView.reloadData()
            }
            
            let archive = UIAlertAction(title: "Archive", style: .default) { [self] _ in
                
                let archived = tasks.remove(at: indexPath.row)
                archivedTasks.append(archived)
                
                tableView.reloadData()
            }
            
            let delete = UIAlertAction(title: "Delete", style: .destructive) { [self] _ in
                
                tasks.remove(at: indexPath.row)
                
                tableView.reloadData()
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            alert.addAction(finish)
            alert.addAction(archive)
            alert.addAction(delete)
            alert.addAction(cancel)
            
            present(alert, animated: true)
        case 1:
            let alert = UIAlertController(title: "Finished Taskdagi taskni ozgartirish", message: nil, preferredStyle: .actionSheet)
            
            let finish = UIAlertAction(title: "Unfinish", style: .default) { [self] _ in
                
                let finished = finishadTasks.remove(at: indexPath.row)
                tasks.append(finished)
                
                tableView.reloadData()
            }
            
            let archive = UIAlertAction(title: "Archive", style: .default) { [self] _ in
                
                let archived = finishadTasks.remove(at: indexPath.row)
                archivedTasks.append(archived)
                
                tableView.reloadData()
            }
            
            let delete = UIAlertAction(title: "Delete", style: .destructive) { [self] _ in
                
                finishadTasks.remove(at: indexPath.row)
                
                tableView.reloadData()
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            alert.addAction(finish)
            alert.addAction(archive)
            alert.addAction(delete)
            alert.addAction(cancel)
            
            present(alert, animated: true)
        default:
            let alert = UIAlertController(title: "Archived Taskdagi taskni ozgartirish", message: nil, preferredStyle: .actionSheet)
            
            let archive = UIAlertAction(title: "Unarchive", style: .default) { [self] _ in
                
                let archived = archivedTasks.remove(at: indexPath.row)
                tasks.append(archived)
                
                tableView.reloadData()
            }
            
            let delete = UIAlertAction(title: "Delete", style: .destructive) { [self] _ in
                
                archivedTasks.remove(at: indexPath.row)
                
                tableView.reloadData()
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            alert.addAction(archive)
            alert.addAction(delete)
            alert.addAction(cancel)
            
            present(alert, animated: true)
        }
    }
    

}
