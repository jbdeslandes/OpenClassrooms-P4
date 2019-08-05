//
//  ViewController.swift
//  P4 - Instagrid
//
//  Created by Jean-Baptiste Deslandes on 23/06/2019.
//  Copyright © 2019 Jean-Baptiste Deslandes. All rights reserved.
//

// pdf schéma MVC

import UIKit

class ViewController: UIViewController {
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Default layout at start
        grid = .layout2

        // Image Picker configuration
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        // Swipe Gesture configuration at start
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(gridViewSwiped))
        guard let swipeGestureRecognizer = swipeGestureRecognizer else { return }
        gridView.addGestureRecognizer(swipeGestureRecognizer)

        
        NotificationCenter.default.addObserver(self, selector: #selector(setUpSwipeDirection), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    // MARK: - Properties

    private let imagePicker = UIImagePickerController()

    private var swipeGestureRecognizer: UISwipeGestureRecognizer?

    private var index: Int = 0
    private var grid: Grid = .layout2 {
        didSet {
            displayDidChange()
        }
    }

    // MARK: - Methods

    private func displayDidChange() {
        for i in 0..<contentViews.count {
            let value = grid.display[i]
            contentViews[i].isHidden = value
        }
    }
    
    /// Share gridView
    private func handleSharing() {

        let shareViewController = UIActivityViewController(activityItems: [gridView.transformToImage], applicationActivities: nil)
        present(shareViewController, animated: true, completion: nil)
        shareViewController.completionWithItemsHandler = { _, _, _, _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.gridView.transform = .identity
            })
        }
    }

    @objc private func setUpSwipeDirection() {
        if UIDevice.current.orientation.isLandscape {
            swipeGestureRecognizer?.direction = .left
        } else {
            swipeGestureRecognizer?.direction = .up
        }
    }
    
    /// Swipe animation
    @objc private func gridViewSwiped() {

        // closure = self.
        if swipeGestureRecognizer?.direction == .up {
            UIView.animate(withDuration: 0.5, animations: {
                self.gridView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            }) { _ in
                self.handleSharing()
            }
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.gridView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            }) { _ in
                self.handleSharing()
            }
        }
    }

    @objc private func imageViewTapped(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        index = tag
        present(imagePicker, animated: true, completion: nil)
    }

    // MARK: - Outlets

    @IBOutlet private weak var gridView: UIView!
    @IBOutlet private var imageViews: [UIImageView]!
    @IBOutlet private var plusButtons: [UIButton]!
    @IBOutlet private var contentViews: [UIView]!
    @IBOutlet private var patternButtons: [UIButton]!

    // MARK: - Actions

    @IBAction private func patternButtonTapped(_ sender: UIButton) {
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

    @IBAction private func plusButtonTapped(_ sender: UIButton) {
        index = sender.tag
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate Methods

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
