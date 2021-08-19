//
//  FilmListViewController.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-19.
//

import Foundation

class FilmListViewController: BaseTableViewController, BindableType {
   var viewModel: FilmListViewModelType!
    
    override func config() {
        title = "Films"
        viewModel = FilmListViewModel()
    }
    
    func bindViewModel() {
        
    }
    
    override func fetchData() {
        viewModel.fetchData()
    }
}
