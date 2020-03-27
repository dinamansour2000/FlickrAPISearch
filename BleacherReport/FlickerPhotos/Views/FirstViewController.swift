//
//  FirstViewController.swift
//  BleacherReport
//
//  Created by Dina Mansour on 3/27/20.
//  Copyright © 2020 Andela. All rights reserved.
//

import UIKit
import Reachability
import Kingfisher

class FirstViewController: UIViewController, UISearchBarDelegate {

    
    var dialogFullScreenView: UIView?
    var dialogLoadingGroup: STLoadingGroup?
    lazy var viewModel = FlickerViewModel()
    lazy var dbManager = FlickerDBManager()
    var objects = FlickerModel()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

     override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
       

       collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        
              
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           
           if ((searchBar.text != "")){
               var searchText = ""
               searchText = searchBar.text!
            
                      
            searchText = searchText.replacingOccurrences(of: " ", with: "")
           
            self.view.endEditing(true)
            viewModel.getFlickerData(title: searchText, delegate: self)
           }
         
       }

      public func showProgressDialog(){
            dialogLoadingGroup = STLoadingGroup(side: 80, style: .arch)
            
            if dialogFullScreenView == nil {
                dialogFullScreenView = UIView(frame: self.view.frame)
                dialogFullScreenView?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue:0.0, alpha: 0.3)
            }
            
            if !(dialogFullScreenView?.isDescendant(of: self.view))!{
                self.view.addSubview(dialogFullScreenView!)
                dialogFullScreenView?.fillScreenLayoutConstrains()
            }
            
            dialogLoadingGroup?.show(dialogFullScreenView)
            dialogLoadingGroup?.startLoading()
        }
        
        public func hideProgressDialog(){
            dialogLoadingGroup?.stopLoading()
            dialogFullScreenView?.removeFromSuperview()
        }
        
        public func showErrorMessage(_ message: String){
            UIHelper.showErrorMessage(message)
        }
        public func showSuccessMessage(_ message: String){
            UIHelper.showSuccessMessage(message)
        }
        public func isNetworkConnected() -> Bool{
            let reachability = Reachability()!
            return reachability.isReachable
        }
        
        public func showNoNetworkConnectedMessage(){
            UIHelper.showErrorMessage(Utils.localizedString(forKey: "noNetworkConnected"))
        }
        
        
        
    }
    
    extension FirstViewController: FlickerRequestDelegate {
        
        
        func requestWillSend() {
            showProgressDialog()
        }
        
        func requestSucceeded(data: FlickerModel?) {
            hideProgressDialog()
            if (data != nil){
                showSuccessMessage("Images Loaded Successfully")
                objects = data!
                let array = Array (objects.photos!.photo)
                dbManager.deleteFlickerData()
                dbManager.saveFlickerData(data: array)
                collectionView.reloadData()
                
            }else{
                showErrorMessage("No Images Available!")
            }
            
            
        }
        
        func requestFailed() {
            hideProgressDialog()
            showNoNetworkConnectedMessage()
        }
        
        
    }

    extension FirstViewController: UICollectionViewDataSource {
        
        func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
            // 1
            // Return the number of sections
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           if ( objects.photos != nil ){
            let array = Array (objects.photos!.photo)
            
            return array.count
            }else{
                return 0
            }
           
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
            
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
            
            let array = Array (objects.photos!.photo)
            let urlString0 = "http://farm"
            let urlString1 = urlString0 + (array[indexPath.row].farm.stringValue) + ".static.flickr.com/"
            let urlString2 = urlString1 + (array[indexPath.row].server)! + "/" + (array[indexPath.row].idNo)!
            let urlString3 = urlString2 + "_" + (array[indexPath.row].secret)! + ".jpg"
            let url = URL(string: urlString3.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)! )
            cell.image.kf.setImage(with: url , placeholder: "noImage" as? Placeholder)

            cell.titleLabel.text = array[indexPath.row].title

            
                return cell
                
        }
        
        
    }

extension FirstViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let array = Array (objects.photos!.photo)
        let detailViewController = DetailViewController(nibName: "DetailViewController", bundle: .main)
        detailViewController.imageSource = array[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
