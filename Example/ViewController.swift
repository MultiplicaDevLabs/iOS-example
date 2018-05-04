//
//  ViewController.swift
//  Example
//
//  Created by Daniel Cabello on 3/22/18.
//  Copyright © 2018 Daniel Cabello. All rights reserved.
//

import UIKit
import Siesta

protocol RespositoryLoadDelegate{
     func load(repositories: [Repository])
}

class ViewController: UIViewController, UISearchBarDelegate, RespositoryLoadDelegate  {
    let multiplicaTable = MultiplicaTable()
    let multiplicaService = MultiplicaService()
    var searchResourceDelegate :SearchResourceDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    func load(repositories: [Repository]) {
        self.repositories = repositories
    }
    
    var repositories: [Repository] = [] {
        didSet {
            multiplicaTable.reloadData(data: repositories)
            tableView.reloadData()
        }
    }

    var searchResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            
            searchResource?
                .addObserver(searchResourceDelegate!)
                .load()
        }
    }
    
    class SearchResourceDelegate: ResourceObserver{
        var loadDelegate: RespositoryLoadDelegate
        init(loadDelegate: RespositoryLoadDelegate) {
            self.loadDelegate = loadDelegate
        }
        
        func resourceChanged(_ resource: Resource, event: ResourceEvent) {
            if !resource.isLoading {
                if resource.jsonArray.count==0 {
                    let search: SearchResult
                    search = resource.typedContent() ?? SearchResult(items: [])
                    self.loadDelegate.load(repositories: search.items)
                }else{
                    let repositories: [Repository]
                    repositories = resource.typedContent() ?? []
                    self.loadDelegate.load(repositories: repositories)
                }
            }

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(GithubFoldingCell.self, forCellReuseIdentifier: String(describing: GithubFoldingCell.self))

        //repositoryResourceDelegate  = RepositoryResourceDelegate(loadDelegate: self)
        searchResourceDelegate = SearchResourceDelegate(loadDelegate: self)
        
        self.tableView.delegate = multiplicaTable
        self.tableView.dataSource = multiplicaTable
        searchResource = multiplicaService.repos("MultiplicaDevLabs")
        self.tableView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        self.tableView.separatorStyle = .none
        self.searchBar.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(_ searchBar: UISearchBar,
                            textDidChange searchText: String){
        if (searchText.count>3){
            searchResource = multiplicaService.search(term: searchText)
        }

        if( searchText.count==0 || searchText == ""){
            searchResource = multiplicaService.repos("MultiplicaDevLabs")
            searchResource?.invalidate()
        }
    }
}

