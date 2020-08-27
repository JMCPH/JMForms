//
//  JMActionSheet.swift
//  JMForms
//
//  Created by Jakob Mikkelsen on 26/08/2020.
//

import UIKit

public protocol JMActionSheetDelegate: class {
    func didSelect(image: UIImage?)
}

open class JMActionSheet: NSObject {

    private let title: String?
    private let message: String?
    private let options: [String]
    private weak var presentationController: UIViewController?
    public var didSelectValue: ((String?) -> ())?

    public init(presentationController: UIViewController, title: String?, message: String?, options: [String]) {
        self.title = title
        self.message = message
        self.options = options
        self.presentationController = presentationController
        super.init()
    }

    public func present(from sourceView: UIView) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        for option in options  {
            let action = UIAlertAction(title: option, style: .default) { _ in
                self.didSelectValue?(option)
            }
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        presentationController?.present(alertController, animated: true)
    }

}
