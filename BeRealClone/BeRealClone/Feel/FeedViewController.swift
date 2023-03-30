//
//  FeelViewController.swift
//  BeRealClone
//
//  Created by CHENGTAO on 3/29/23.
//

import UIKit
import ParseSwift


class FeedViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var postStateLocation: String!
    
    private var posts = [Post]() {
        didSet {
            postTableView.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.allowsSelection = false
        addRefresh()
    }
    

    @IBAction func didLogoutTapped(_ sender: Any) {
        
        showConfirmLogoutAlert()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        queryPosts()
    }

    private func queryPosts() {
        // https://github.com/parse-community/Parse-Swift/blob/3d4bb13acd7496a49b259e541928ad493219d363/ParseSwift.playground/Pages/2%20-%20Finding%20Objects.xcplaygroundpage/Contents.swift#L66
        
        // 1. Create a query to fetch Posts
        // 2. Any properties that are Parse objects are stored by reference in Parse DB and as such need to explicitly use `include_:)` to be included in query results.
        // 3. Sort the posts by descending order based on the created at date
        let query = Post.query()
            .include("user")
            .order([.descending("createAt")])
        
        // Fetch object (posts) defined in query (async)
        query.find { [weak self] result in
            switch result {
            case .success(let post):
                // Update local posts property with fetched posts
                self?.posts = post
            case .failure(let err):
                self?.showAlert(description: err.localizedDescription)
            }
        }
    }
    

    @objc func onRefresh() {
        run(after: 1.5) {
               self.refreshControl.endRefreshing()
            }
    }
    
    // Implement the delay method
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    /// Add the UIRefreshControl to the UITableView
    func addRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        refreshControl.tintColor = .white
        postTableView.insertSubview(refreshControl, at: 0)
    }
    
    private func showConfirmLogoutAlert() {
        let alertController = UIAlertController(title: "Log out of your account?", message: nil, preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }

}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        cell.configure(with: posts[indexPath.row])
        return cell
    }
}


extension FeedViewController: UITableViewDelegate { }

