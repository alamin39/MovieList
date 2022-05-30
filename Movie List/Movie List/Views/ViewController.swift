//
//  ViewController.swift
//  Movie List
//
//  Created by Al-Amin on 30/5/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var movieList = [ResultsInfo]()
    private let cellIdentifier = "cell"
    private let xibIdentifier = "MovieInfoCell"
    private let cellHeight = 250
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie List"
        setupTableView()
        fetchData()
    }
    
    private func fetchData() {
        NetworkManager().fetchMovies(completionHandler: { [weak self] movies in
            self?.movieList = movies
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: xibIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func getImage(from string: String) -> UIImage? {
        guard let url = URL(string: string) else {
            NSLog("Unable to create URL!")
            return nil
        }
        
        var image: UIImage? = nil
        do {
            let data = try Data(contentsOf: url, options: [])
            image = UIImage(data: data)
        } catch {
            NSLog(String(describing: error))
        }
        return image
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MovieInfoCell
        
        cell.moviePoster.image = getImage(from: "https://image.tmdb.org/t/p/w500" + movieList[indexPath.row].poster_path)
        cell.titleLabel.text = movieList[indexPath.row].title
        cell.subTitleLabel.text = movieList[indexPath.row].overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
}
