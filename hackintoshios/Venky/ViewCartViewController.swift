//
//  ViewCartViewController.swift
//  hackintoshios
//
//  Created by Venkat on 10/07/21.
//

import UIKit

class ViewCartViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var cartLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var tableview2: UITableView!
    @IBOutlet weak var tableview2Height: NSLayoutConstraint!
    @IBOutlet weak var payNOWbTN: UIButton!
    @IBOutlet weak var changeLbl: UILabel!
    @IBOutlet weak var addressTxtfld: UITextView!
    @IBOutlet weak var addressViewHgt: NSLayoutConstraint!
    @IBOutlet weak var addreesView: UIView!
    
    @IBOutlet weak var savebtn: UIButton!
    
    var hidden = true
    var toolBar = UIToolbar()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "viewCartTableViewCell", bundle: nil), forCellReuseIdentifier: "viewCartTableViewCell")
        tableview.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        tableview2.delegate = self
        tableview2.dataSource = self
        tableview2.register(UINib(nibName: "TimeDeliverTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeDeliverTableViewCell")
        tableview2.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        let uparrow = UITapGestureRecognizer(target: self, action: #selector(change))
        changeLbl.addGestureRecognizer(uparrow)
        changeLbl.isUserInteractionEnabled = true
        setupToolBar()
        // Do any additional setup after loading the view.
    }
    
    func setupToolBar() {
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "DONE", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton ,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.tintColor = .darkGray
        addressTxtfld.inputAccessoryView = toolBar
    }
    
    @objc func donePicker(){
        view.endEditing(true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?)
    {
        tableview.layer.removeAllAnimations()
        tableviewHeight.constant = tableview.contentSize.height
        tableview2.layer.removeAllAnimations()
        tableview2Height.constant = tableview2.contentSize.height
        UIView.animate(withDuration: 0.5)
        {
            self.updateViewConstraints()
        }
    }
    
    @objc func change() {
        if hidden == true {
            hidden = false
        addressViewHgt.constant = 120
        savebtn.isHidden = false
        } else {
            hidden = true
            addressViewHgt.constant = 0
            savebtn.isHidden = true
        }
    }
    
    @IBAction func PAYNOW(_ sender: Any) {
        
    }
    
    @IBAction func SAVE(_ sender: Any) {
        addressLbl.text = "Delivery to: \(addressLbl.text)"
        addressLbl.text = ""
        hidden = true
        addressViewHgt.constant = 0
        savebtn.isHidden = true
    }
    
    func setupUI() {
        headerView.roundCorners([.topLeft, .bottomRight], radius: 50)
        payNOWbTN.layer.cornerRadius = 5
        addressViewHgt.constant = 0
        addreesView.layer.borderWidth = 1
        addreesView.layer.borderColor = UIColor.systemGray4.cgColor
        addreesView.layer.cornerRadius = 5
        savebtn.isHidden = true
        hidden = true
        
    }

//    @objc func plusButton() {
//        let cell = tableview.cellForRow(at: IndexPath(row: index, section: 0)) as! viewCartTableViewCell
//
//    }
//    @objc func lessButton() {
//        let cell = tableview.cellForRow(at: IndexPath(row: index, section: 0)) as! viewCartTableViewCell
//
//    }

}

extension ViewCartViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var value = 0
        if tableView == tableview {
            value =  2
        } else if tableView == tableview2 {
            value =  2
        }
        return value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == tableview {
            let cell = tableview.dequeueReusableCell(withIdentifier: "viewCartTableViewCell", for: indexPath) as! viewCartTableViewCell
//            cell.plusBtn.addTarget(self, action: #selector(plusButton), for: .touchUpInside)
//            cell.lessBtn.addTarget(self, action: #selector(lessButton), for: .touchUpInside)
            cell.quantityBtn.text = "1"
            return cell
        } else if tableView == tableview2 {
            let cell = tableview2.dequeueReusableCell(withIdentifier: "TimeDeliverTableViewCell", for: indexPath) as! TimeDeliverTableViewCell
            return cell
        }
        else
        {
            let cell = UITableViewCell()
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 0
        if tableView == tableview {
            height = 150
        } else if tableView == tableview2 {
            height = 40
        }
        return CGFloat(height)
    }
    
}


extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        self.clipsToBounds = true
       }
}
