//
//  DogsInfoViewController.swift
//  DownloadImagesWIthSpinner
//
//  Created by RaviKrishna on 17/05/24.
//

import UIKit

class DogsInfoViewController: UIViewController {

    @IBOutlet weak var collectionViewObj: UICollectionView!
    var viewModel:DogsInfoViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
        self.loadDogInfo()
    }
    
    func config(){
        viewModel = DogsInfoViewModel()
        collectionViewObj.delegate = self
        collectionViewObj.dataSource = self
    }
    func loadDogInfo(){
        viewModel?.getDogsInfoServiceCall {
            DispatchQueue.main.async {
                self.collectionViewObj.reloadData()
            }
        }
    }
}
extension DogsInfoViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.imageLinks.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewObj.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DogsInfoCollectionCell
        let urlImage = URL(string: viewModel?.imageLinks[indexPath.row] ?? "")
        cell.imageViewObj.downloadImage(from: urlImage!)
        cell.imageViewObj.layer.cornerRadius = 50
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 10) / 2
        return CGSize(width: size, height: size)
    }
}

extension UIImageView{
    func downloadImage(from url: URL){
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        spinner.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        self.addSubview(spinner)
        contentMode = .scaleToFill
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {return}
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.image = image
                spinner.stopAnimating()
            }
        }.resume()
    }
}
