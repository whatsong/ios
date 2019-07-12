//
//  FloatingEditLauncher.swift
//  whatsong v3
//
//  Created by Tom Andrew on 26/6/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class FloatingEditLauncher: UIView, UITextViewDelegate  {
        
    var song: Song! {
        didSet  {
            songTitle.text = song.title
            artistName.text = song.artist.name
            if(self.isEditTime){
                if song.time_play != nil   {
                    print("time is not nil")
                    textTimeView.text = "\(song.time_play ?? 0)"
                    textTimeView.textColor = UIColor.brandBlack()
                    contributorLabel.text = "The time has already been added."
                }
            }
            else{
                if song.scene_description != nil && song.scene_description != ""   {
                    print("scene is not nil")
                    textView.text = song.scene_description
                    textView.textColor = UIColor.brandBlack()
                }
                if song.scene_description?.count ?? 0 > 3   {
                    contributorLabel.text = "This scene was added by another user."
                    //contributorLabel.text = "This scene was added by \(song.user_scene ?? 0)"
                }
            }
            
        }
    }
    
    var handleSaveText: (String) -> Void = {_  in }
    var handleSaveInt: (Int) -> Void = {_ in }
    var handleCloseText:() -> Void = {}
    var isEditTime : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(isEditTime: Bool) {
        super.init(frame: .zero)
        textView.delegate = self
        textTimeView.delegate = self
        self.isEditTime = isEditTime
        setupViews()
        setupKeyboardListeners()
        
    }
    //MARK: Setup Views
    
    func setupViews()   {
        // Heading Views
        let headingStackView = VerticalStackView(arrangedSubviews: [songTitle, artistName])
        headingBackground.constrainHeight(constant: 70)
        headingBackground.addSubview(headingStackView)
        headingStackView.fillSuperview(padding: UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20))
        
        // Middle Views
        let middleStackView = VerticalStackView(arrangedSubviews: [self.isEditTime ? questionTimeHeading : questionHeading, self.isEditTime ? textTimeView : textView, contributorLabel])
        middleBackground.addSubview(middleStackView)
        middleStackView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        
        // Footer Views
        let buttonStackView = UIStackView(arrangedSubviews: [cancelButton, saveButton])
        buttonStackView.distribution = .fillEqually
        footerBackground.constrainHeight(constant: 70)
        footerBackground.addSubview(buttonStackView)
        buttonStackView.fillSuperview()
        
        //Final Combined StackView
        let stackView = VerticalStackView(arrangedSubviews: [headingBackground, middleBackground, footerBackground], spacing: 0)
        
        addSubview(stackView)
        
        stackView.fillSuperview()
        
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
    }
    
    //MARK: Setup Keyboard Listeners
    
    func setupKeyboardListeners()    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else   {
            return
        }
        
        let window = UIApplication.shared.keyWindow
        let windowHeight = window?.frame.height
        guard let bottomSafeHeight = window?.safeAreaInsets.bottom else { return }
        let viewHeight: CGFloat = 380 + bottomSafeHeight
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification    {
            frame.origin.y = windowHeight! - keyboardRect.height - viewHeight
        }   else    {
            frame.origin.y = windowHeight! - viewHeight
        }
    }
    
    // MARK:- Methods, Functions
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView == self.textView){
            if textView.textColor == UIColor.brandLightGrey() {
                textView.text = nil
                textView.textColor = UIColor.brandBlack()
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView == self.textView){
            if textView.text.isEmpty {
                textView.text = "Example - Mary and Tom go on their first date at the bowling alley."
                textView.textColor = UIColor.brandLightGrey()
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        else if(textView == self.textTimeView)
        {
            let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let components = text.components(separatedBy: inverseSet)
            let filtered = components.joined(separator: "")
            return text == filtered
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
        textTimeView.resignFirstResponder()

    }
    
    @objc func handleDismissFloatingView()    {
        guard let bottomSafeHeight = window?.safeAreaInsets.bottom else { return }
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.transform = .init(translationX: 0, y: bottomSafeHeight)
        }) { (_) in
            self.removeFromSuperview()
        }
         self.handleCloseText()
    }
    
    // MARK:- Views
    
    let headingBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundGrey()
        return view
    }()
    
    let middleBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let footerBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundGrey()
        return view
    }()
    
    let songTitle: UILabel = {
        let label = UILabel()
        label.text = "White Hinterland"
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.brandBlack()

        return label
    }()
    
    let artistName: UILabel = {
        let label = UILabel()
        label.text = "Kairos"
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.brandLightGrey()
        return label
    }()
    
    var questionHeading: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "What scene did this song play in?", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.brandLightGrey()
        label.constrainHeight(constant: 65)
        return label
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.color = UIColor.brandLightGrey()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    var questionTimeHeading: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "How many minutes in did this song play?", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.brandLightGrey()
        label.constrainHeight(constant: 65)
        return label
    }()
    var textTimeView: UITextView = {
        let tv = UITextView()
        tv.attributedText = NSAttributedString(string: "", attributes: [
            NSAttributedString.Key.kern: -0.6,
            NSAttributedString.Key.foregroundColor: UIColor.brandBlack()
            ])
        tv.font = UIFont(name: "Montserrat-Regular", size: 14)
        tv.constrainHeight(constant: 110)
        tv.backgroundColor = UIColor.backgroundGrey()
        tv.returnKeyType = UIReturnKeyType.done
        tv.keyboardType = UIKeyboardType.numberPad
        return tv
    }()
    
    var textView: UITextView = {
        let tv = UITextView()
        tv.attributedText = NSAttributedString(string: "Example - Mary and Tom go on their first date at the bowling alley.", attributes: [
            NSAttributedString.Key.kern: -0.6,
            NSAttributedString.Key.foregroundColor: UIColor.brandLightGrey()
            ])
        tv.font = UIFont(name: "Montserrat-Regular", size: 14)
        tv.constrainHeight(constant: 110)
        tv.backgroundColor = UIColor.backgroundGrey()
        tv.returnKeyType = UIReturnKeyType.done
        return tv
    }()
    
    let contributorLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Gain +5 points for adding a correct scene", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        label.font = UIFont(name: "Montserrat-Regular", size: 13)
        label.textColor = UIColor.brandLightGrey()
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.brandLightGrey(), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        button.addTarget(self, action: #selector(handleDismissFloatingView), for: .touchUpInside)
        button.titleLabel?.textColor = UIColor.brandLightGrey()
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor.brandPurple(), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        button.addTarget(self, action: #selector(saveText), for: .touchUpInside)
        return button
    }()
    
    @objc func saveText() {
        self.endEditing(true)
        if(self.isEditTime){
            let text = textTimeView.text
            if(text!.count > 0){
                self.activityIndicatorView.startAnimating()
                self.handleSaveInt(Int(text!)!)
            }
            else{
                self.showAlert(bgColor: .clear, text: "Please add How many minutes in did this song play?")
            }
        }
        else{
            let text = textView.text == "Example - Mary and Tom go on their first date at the bowling alley." ? "" : textView.text
            if(text!.count > 0){
                self.activityIndicatorView.startAnimating()
                self.handleSaveText(text!)
            }
            else{
                self.showAlert(bgColor: .clear, text: "Please add scene description")
            }
        }
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
