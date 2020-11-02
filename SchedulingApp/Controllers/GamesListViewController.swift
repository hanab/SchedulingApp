//
//  ViewController.swift
//  SchedulingApp
//
//  Created by Hana  Demas on 10/28/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import UIKit

class GamesListViewController: UIViewController {

    //MARK: Properties
    @IBOutlet var gamesTableView: UITableView!
    var gamesViewModel = GamesViewModel()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                        #selector(GamesListViewController.handleRefresh(_:)),
                                    for: UIControl.Event.valueChanged)
        
        return refreshControl
    }()
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gamesTableView.rowHeight = UITableView.automaticDimension
        gamesTableView.estimatedRowHeight = 120
        SetupNavigation()
        
        gamesTableView.addSubview(refreshControl)
        
        let headerNib = UINib(nibName: "GamesSectionHeader", bundle: nil)
        gamesTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        let cellNib = UINib(nibName: "ByeTableViewCell", bundle: nil)
        gamesTableView.register(cellNib, forCellReuseIdentifier: "byeCell")
        
        loadData()
    }
    
    private func loadData() {
        gamesViewModel.fetchGames {
            DispatchQueue.main.async {
                self.gamesTableView.reloadData()
            }
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadData()
        refreshControl.endRefreshing()
    }
    
    private func SetupNavigation() {
        self.navigationController?.navigationBar.barTintColor =  UIColor.yinzDarkGreen()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font :  UIFont(name: "MavenProBold", size: 20)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        self.title = "SCHEDULE"
    }
}

//MARK: tableview datasource and delegate methodes
extension GamesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerCellsForTableView(tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return gamesViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.gamesTableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! GamesSectionHeader
        header.headerTitle.text = gamesViewModel.sectionHeaderTitle(section: section)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameElement = gamesViewModel.gameAtIndexPathRow(section: indexPath.section, indexPath: indexPath.row).1
        let team = gamesViewModel.gameAtIndexPathRow(section: indexPath.section, indexPath: indexPath.row).0
        let gameType = gameElement?.type ?? TypeEnum.b
        
        switch gameType {
        case .f, .s:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameTableViewCell
            if let team = team, let gameEle = gameElement {
                cell.setUPViews(team: team, game: gameEle)
            }
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "byeCell" , for: indexPath) as! ByeTableViewCell
            cell.weekLabel.text = gameElement?.week
            cell.center = view.center
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

