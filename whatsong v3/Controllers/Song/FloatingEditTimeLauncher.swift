//
//  FloatingEditTimeView.swift
//  whatsong v3
//
//  Created by Tom Andrew on 12/7/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class FloatingEditTimeLauncher: FloatingEditLauncher    {
    
    override var song: Song! {
        didSet  {
            songTitle.text = song.title
            artistName.text = song.artist.name
            if song.time_play != nil   {
                print("time is not nil")
                textTimeView.text = "\(song.time_play ?? 0)"
                textTimeView.textColor = UIColor.brandBlack()
                contributorLabel.text = "The time has already been added."
            }
        }
    }
    
    override func setupViews() {
        // Heading Views
        let headingStackView = VerticalStackView(arrangedSubviews: [songTitle, artistName])
        headingBackground.constrainHeight(constant: 70)
        headingBackground.addSubview(headingStackView)
        headingStackView.fillSuperview(padding: UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20))
        
        // Middle Views
        let middleStackView = VerticalStackView(arrangedSubviews: [questionTimeHeading, textTimeView, contributorLabel])
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
}
