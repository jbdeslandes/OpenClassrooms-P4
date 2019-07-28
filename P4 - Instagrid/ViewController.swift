//
//  ViewController.swift
//  P4 - Instagrid
//
//  Created by Jean-Baptiste Deslandes on 23/06/2019.
//  Copyright © 2019 Jean-Baptiste Deslandes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        grid = .layout2

        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(gridViewSwiped))
        guard let swipeGestureRecognizer = swipeGestureRecognizer else { return }
        gridView.addGestureRecognizer(swipeGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setUpSwipeDirection), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    // MARK: - Properties

    let imagePicker = UIImagePickerController()

    var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    var index: Int = 0
    var grid: Grid = .layout2 {
        didSet {
            displayDidChange()
        }
    }

    // MARK: - Methods

    func displayDidChange() {
        for i in 0..<contentViews.count {
            let value = grid.display[i]
            contentViews[i].isHidden = value
        }
    }
    
    @objc func setUpSwipeDirection() {
        if UIDevice.current.orientation.isLandscape {
            swipeGestureRecognizer?.direction = .left
        } else {
            swipeGestureRecognizer?.direction = .up
        }
    }
    
    @objc func gridViewSwiped() {
//      Demande d'explications
        let renderer = UIGraphicsImageRenderer(size: gridView.bounds.size)
        let image = renderer.image { ctx in
            gridView.drawHierarchy(in: gridView.bounds, afterScreenUpdates: true)
        }
        
        let shareViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(shareViewController, animated: true, completion: nil)
    }
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
//        if let tag = sender.view?.tag {
//            index = tag
//        }
        guard let tag = sender.view?.tag else { return }
        index = tag
        present(imagePicker, animated: true, completion: nil)
    }

    // MARK: - Outlets

    @IBOutlet weak var gridView: UIView!
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet var plusButtons: [UIButton]!
    @IBOutlet var contentViews: [UIView]!
    @IBOutlet var patternButtons: [UIButton]!

    // MARK: - Actions

    @IBAction func patternButtonTapped(_ sender: UIButton) {
        patternButtons.forEach { $0.isSelected = false }
        sender.isSelected = true
        switch sender.tag {
        case 0:
            grid = .layout1
        case 1:
            grid = .layout2
        case 2:
            grid = .layout3
        default:
            break
        }
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        index = sender.tag
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - UIImagePickerControllerDelegate Methods

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageViews[index].image = pickedImage
            plusButtons[index].isHidden = true
            let tapGestureRecongnizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
            imageViews[index].addGestureRecognizer(tapGestureRecongnizer)
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}

