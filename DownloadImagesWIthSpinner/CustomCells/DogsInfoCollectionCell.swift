//
//  DogsInfoCollectionCell.swift
//  DownloadImagesWIthSpinner
//
//  Created by RaviKrishna on 17/05/24.
//

import UIKit

class DogsInfoCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewObj: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewObj.image = nil
    }
}
