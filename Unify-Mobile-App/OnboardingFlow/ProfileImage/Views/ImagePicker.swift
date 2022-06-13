//
//  ImagePicker.swift
//  Unify
//
//  Created by Melvin Asare on 07/10/2021.
//

import UIKit

public protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?)
    func didDismissPicker(image: UIImage?)
}

class ImagePicker: NSObject, UINavigationControllerDelegate {

    private let pickerController: UIImagePickerController
    private weak var presentationController: (UIViewController & ImagePickerDelegate)?

    init(presentationController: UIViewController & ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        super.init()

        self.presentationController = presentationController

        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }

    public func present(from sourceView: UIView) {
        self.presentationController?.present(pickerController, animated: true, completion: nil)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true) { [weak self] in
            self?.presentationController?.didDismissPicker(image: image)
        }
        presentationController?.didSelect(image: image)
    }
}

