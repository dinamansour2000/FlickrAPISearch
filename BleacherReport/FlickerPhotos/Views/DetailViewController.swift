//
//  DetailViewController.swift
//  BleacherReport
//
//  Created by Dina Mansour on 3/27/20.
//  Copyright © 2020 Andela. All rights reserved.
//

import UIKit
import Reachability
import Kingfisher

class DetailViewController: UIViewController {

    public var imageSource:PhotoModel?
    @IBOutlet weak var image: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.navigationController?.navigationBar.isHidden = false

        self.navigationController?.navigationBar.topItem?.title = imageSource?.title

        if (isNetworkConnected()){
         let urlString0 = "http://farm"
        let urlString1 = urlString0 + ((imageSource?.farm.stringValue)!) + ".static.flickr.com/"
        let urlString2 = urlString1 + (imageSource?.server)! + "/" + (imageSource?.idNo)!
        let urlString3 = urlString2 + "_" + (imageSource?.secret)! + ".jpg"
         let url = URL(string: urlString3.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)! )
         image.kf.setImage(with: url , placeholder: "noImage" as? Placeholder)
        }
    }


    public func isNetworkConnected() -> Bool{
        let reachability = Reachability()!
        return reachability.isReachable
    }

    public func showNoNetworkConnectedMessage(){
        UIHelper.showErrorMessage(Utils.localizedString(forKey: "noNetworkConnected"))
    }

}
