//
//  ViewController.swift
//  Wongnai iOS Assignment
//
//  Created by Suchaya K. on 9/1/2565 BE.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import SystemConfiguration

class ViewController: UIViewController {
    
    @IBOutlet weak var contentPage: ListView!
    
    var allDetail = [Detail]()
    var dataList = Detail(name: "", description: "", positive_votes_count: 0, image_url: "")
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentPage.valueTableView.dataSource = self
        self.contentPage.valueTableView.delegate = self
        self.contentPage.valueTableView.rowHeight = UITableView.automaticDimension
        
        self.contentPage.valueTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "listtableviewcell")
        self.contentPage.valueTableView.register(UINib(nibName: "InsertionTableViewCell", bundle: nil), forCellReuseIdentifier: "insertiontableviewcell")
        
        let pageNum = String(page)
        self.loadDetail(page: pageNum, refresh: true)
        
        self.contentPage.valueTableView.refreshControl = UIRefreshControl()
        self.contentPage.valueTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
    }
    
    func loadDetail(page: String, refresh: Bool = false) {
        let apiPath = "https://api.500px.com/v1/photos?feature=popular&page=\(page)"
        AF.request(apiPath).responseJSON { responseData in
            if refresh {
                self.allDetail.removeAll()
                self.contentPage.valueTableView.refreshControl?.endRefreshing()
            }
            DispatchQueue.main.async {
                switch responseData.result {
                case .success:
                    let jsonData = try? JSON(data: responseData.data!)
                    
                    let jsonDataArray = jsonData!["photos"]
                    var num = 1
                    for i in jsonDataArray.arrayValue {
                        if num % 5 == 0 {
                            
                            self.dataList.name = ""
                            self.dataList.description = ""
                            self.dataList.positive_votes_count = 0
                            self.dataList.image_url = ""
                            
                            self.allDetail.append(self.dataList)
                            
                        } else {
                            
                            self.dataList.name = i["name"].stringValue
                            self.dataList.description = i["description"].stringValue
                            self.dataList.positive_votes_count = i["positive_votes_count"].int32
                            self.dataList.image_url = i["image_url"][0].stringValue
                            
                            self.allDetail.append(self.dataList)
                        }
                        num+=1
                    }
                    self.contentPage.valueTableView.reloadData()
                    
                case .failure:
                    print("Error Occured \(responseData.error!)")
                }
            }
            
        }
    }
    
    @objc private func refreshData() {
        page = 1
        let pageNum = String(page)
        self.loadDetail(page: pageNum, refresh: true)
    }

}

extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allDetail.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != 0 && (indexPath.row + 1) % 5 == 0, let cell = tableView.dequeueReusableCell(withIdentifier: "insertiontableviewcell", for: indexPath) as? InsertionTableViewCell {
            
            return cell
        } else {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "listtableviewcell", for: indexPath) as? ListTableViewCell {
                
                cell.keyLabel.text = allDetail[indexPath.row].name
                cell.detailLabel.text = allDetail[indexPath.row].description
                cell.likeCountLabel.text = allDetail[indexPath.row].countLike_string()
                
                let img_url = allDetail[indexPath.row].image_url

                AF.request(img_url!).responseImage { response in
                    switch response.result {
                    case .success:
                        cell.imgImgView.image = response.value
                    case .failure:
                        print("Error Occured \(response.error!)")
                    }
                }
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.allDetail.count - 1{
            page+=1
            let pageNum = String(page)
            loadDetail(page: pageNum, refresh: false)
        }
    }
    
}

extension ViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }


}

