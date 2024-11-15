//
//  NewsListViewController.swift
//  JustNews
//
//  Created by Bawenang RPP on 14/11/24.
//

import UIKit
import RxCocoa
import RxSwift
import SegueManager

class NewsListViewController: UITableViewController, SeguePerformer {
    
    private let viewModel: NewsListViewModel = {
        let newsItemRepo = NewsItemRepository()
        let getNews = GetNews(newsItemRepo: newsItemRepo)
        return NewsListViewModel(getNews: getNews)
    }()
    
    private var newsList = [NewsItem]()
    private let disposeBag = DisposeBag()
    
    lazy var segueManager: SegueManager = {
      // SegueManager based on the current view controller
      return SegueManager(viewController: self)
    }()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      segueManager.prepare(for: segue)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupTableView()
        
        viewModel.viewLoad.accept(())

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsList.count
    }

    private func setupViewModel() {
        viewModel.newsList.drive(onNext: { [weak self] news in
            self?.newsList = news
            self?.tableView.reloadData()
        })
        .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "NewsListTableViewCell", bundle: nil), forCellReuseIdentifier: "newsListTableViewCell")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsListTableViewCell", for: indexPath)

        if let newsListCell = cell as? NewsListTableViewCell {
            newsListCell.setup(news: newsList[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showStory") { (story: NewsStoryViewController) in
            story.news = self.newsList[indexPath.row]
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}
