import UIKit

import PopupDialog
extension UIViewController {

    /// This function allows us to change the controller without presenting it.

    /// It is quite useful at the auto sign-in process.

    func transitionMaker(rootController: UIViewController, duration: TimeInterval=0.3) {

        let appDel = UIApplication.shared.delegate as? AppDelegate

        let homeWindow = appDel?.window

        homeWindow?.rootViewController = rootController

        self.dismiss(animated: true, completion: nil)

        UIView.transition(with: homeWindow!, duration: duration, options: [.transitionCrossDissolve], animations: nil, completion: nil)

    }

    /// This function allows us to hide the keyboard when we tap around.

    /// This function might be useful in the base view controller. So It affects all views.

    func hideKeyboardWhenTappedAround() {

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {

        view.endEditing(true)

    }

    /// This function allows us to show native iOS alerts.

    open func showAlert(title: String, message: String, actions: [UIAlertAction], preferredStyle: UIAlertControllerStyle = .actionSheet) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        for action in actions { alert.addAction(action) }

        alert.popoverPresentationController?.sourceView = self.view

        self.present(alert, animated: true, completion: nil)

    }


    /// This function allows us to show alerts from PopupDialog, which is a pod.

    open func showCoolAlert(title: String, message: String, actions: [PopupDialogButton]) {

        let popup = PopupDialog(title: title, message: message, tapGestureDismissal: false)

        popup.addButtons(actions)

        present(popup, animated: true, completion: nil)

    }

    

    /// This function allows us to show alerts from PopupDialog by using our private view controller.

    open func showCoolAlert(withVC vc: UIViewController, action: PopupDialogButton){

        let popup = PopupDialog(viewController: vc, preferredWidth: 320, tapGestureDismissal: false)

        popup.addButton(action)

        present(popup, animated: true, completion: nil)

    }
 

}
