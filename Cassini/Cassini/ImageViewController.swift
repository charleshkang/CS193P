//
//  ImageViewController.swift
//  Cassini
//
//  Created by Charles Kang on 8/29/16.
//  Copyright © 2016 Charles Kang. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController
{
    @IBOutlet weak var scrollView: UIScrollView!
    {
        didSet {
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    var imageURL: NSURL? {
        didSet {
            image = nil
            fetchImage()
        }
    }
    
    private var imageView = UIImageView()
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    private func fetchImage()
    {
        if let url = imageURL {
            if let imageData = NSData(contentsOfURL: url) {
                image = UIImage(data: imageData)
            }
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        imageURL = NSURL(string: DemoURL.Stanford)
    }

}
