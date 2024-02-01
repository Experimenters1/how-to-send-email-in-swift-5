//
//  ViewController.swift
//  User Send_Email
//
//  Created by Huy Vu on 1/31/24.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func sendEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            sendMail()
        } else {
            // Handle the case where the device cannot send email
            let alertController = UIAlertController(title: "Error", message: "Your device cannot send email.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    private func sendMail(){
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setToRecipients(["huy106964@huce.edu.vn"])

        mailComposeViewController.setSubject("Feedback your app!")
        mailComposeViewController.setMessageBody("Description", isHTML: false)

        present(mailComposeViewController, animated: true, completion: nil)
    }
    
    // MARK: - MFMailComposeViewControllerDelegate

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)

        var title: String = ""
        var message: String = ""
        var action: (() -> Void)?

        switch result {
        case .cancelled:
            title = "Mail cancelled"
            message = "The email has been cancelled."
        case .saved:
            title = "Mail saved"
            message = "The email has been saved as a draft."
        case .sent:
            title = "Mail sent"
            message = "The email has been sent successfully."
        case .failed:
            title = "Mail failed"
            if let error = error {
                message = "The email failed with error: \(error.localizedDescription)"
            } else {
                message = "The email failed."
            }
        @unknown default:
            fatalError()
        }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Handle OK button action if needed
            action?()
        }

        alertController.addAction(okAction)

        // Present the UIAlertController
        present(alertController, animated: true, completion: nil)
    }

    
    
 
}

