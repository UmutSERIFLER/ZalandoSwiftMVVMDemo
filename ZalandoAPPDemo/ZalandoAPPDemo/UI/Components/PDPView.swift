//
//  PDPView.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit
import Kingfisher

class PDPView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initUIView(){
        Bundle.main.loadNibNamed(PDPView.identifier, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setProductInformations(product: Product){
        productName.text = product.title
        productDescription.text = product.description
        productPrice.text = product.price.getFormattedPrice()
        guard let imageUrl = URL(string: product.image)  else {
            return
        }
        productImage.kf.setImage(with: imageUrl)
    }

}

