//
//  EditTimeController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 25/6/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class EditSongLauncher: UIView {
    
    let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSave)))
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    func showEditView() {
        
        if let window = UIApplication.shared.keyWindow  {
            
            window.addSubview(dimmedView)
            window.addSubview(collectionView)
            
            dimmedView.frame = window.frame
            dimmedView.alpha = 0
            
            let height: CGFloat = 400
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.dimmedView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleSave()    {
        print("Handling save")
        UIView.animate(withDuration: 0.5) {
            self.dimmedView.alpha = 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
