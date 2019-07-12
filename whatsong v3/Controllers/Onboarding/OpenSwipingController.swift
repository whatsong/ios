//
//  OpenScreen.swift
//  whatsong v3
//
//  Created by Tom Andrew on 16/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class OpenSwipingController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override var prefersStatusBarHidden: Bool   {
        return true
    }
    
    var headingText = [nil, "Discover", "Find", "Contribute", "Collect", "Just Launched"]
    var subHeading: [String?] = [nil,
                      "Discover music from the latest movies and television shows, updated daily",
                      "Easily find songs with audio samples, scene descriptions and time stamps",
                      "Found a song that hasn't been added yet? Add it yourself to gain points and help other users",
                      "Add songs you love to your library of favorites and track your contributions",
                      "The iOS app has just been launched so we'd love to hear any feedback or suggestions"
    ]
    var imageName: [String?] = ["text-logo", "screenshot-1", "screenshot-2", "screenshot-3", "screenshot-4", nil]
    
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    
    let cellId = "cellId"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .gray
        pc.numberOfPages = 6
        pc.currentPageIndicatorTintColor = UIColor.brandPurple()
        pc.backgroundColor = UIColor.backgroundGrey()
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.brandPurple(), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        button.addTarget(self, action: #selector(handleLoginClicked), for: .touchUpInside)
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.brandPurple()
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        button.addTarget(self, action: #selector(handleSignUpClicked), for: .touchUpInside)
        return button
    }()
    
    let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue without logging in", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        button.setTitleColor(UIColor.brandLightGrey(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundGrey()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SwipedPageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.isPagingEnabled = true
        
        let buttonStackView = UIStackView(arrangedSubviews: [loginButton, registerButton])
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(buttonStackView)
        view.addSubview(skipButton)
        
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: pageControl.topAnchor, trailing: view.trailingAnchor)
        
        pageControl.anchor(top: nil, leading: view.leadingAnchor, bottom: buttonStackView.topAnchor, trailing: view.trailingAnchor)
        pageControl.constrainHeight(constant: 40)
        
        buttonStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: skipButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 10, right: 20))
        buttonStackView.constrainHeight(constant: 50)
        
        skipButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 10, right: 20))
        skipButton.constrainHeight(constant: 25)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SwipedPageCell
        cell.headingText.attributedText = NSAttributedString(string: headingText[indexPath.item] ?? "", attributes: [
            NSAttributedString.Key.kern: -1.0
            ])
        cell.subheading.attributedText = NSAttributedString(string: subHeading[indexPath.item] ?? "" , attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        if indexPath.item == 0 {
            cell.imageScreenshot.image = UIImage(named: imageName[indexPath.item] ?? "")
            cell.imageScreenshot.constrainWidth(constant: view.frame.width * 0.6)
            cell.imageScreenshot.alignTop = false
            cell.setupViews(distribution: .fill, alignment: .center, spacing: 0)
        } else  {
            cell.imageScreenshot.image = UIImage(named: imageName[indexPath.item] ?? "")
            cell.imageScreenshot.alignTop = true
            cell.imageScreenshot.constrainHeight(constant: view.frame.height * 0.60)
            cell.setupViews(distribution: .fillProportionally, alignment: .fill, spacing: 0)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 135 = 10 + 25 + 10 + 50 + 40
        return CGSize(width: view.frame.width, height: view.frame.height - 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
    }
    
    func presentCustom(vc: UIViewController, animated: Bool) {
        
        presentTransition = RightToLeftTransition()
        dismissTransition = LeftToRightTransition()
        
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        
        present(vc, animated: true, completion: { [weak self] in
            self?.presentTransition = nil
        })
    }
    
    @objc func handleLoginClicked()   {
        self.presentCustom(vc: LoginController(), animated: true)
    }
    
    @objc func handleSignUpClicked()   {
        self.presentCustom(vc: SignUpController(), animated: true)
    }
    
    @objc func handleSkip()   {
        self.dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

