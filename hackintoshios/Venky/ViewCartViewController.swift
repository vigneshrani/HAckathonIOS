//
//  ViewCartViewController.swift
//  hackintoshios
//
//  Created by Venkat on 10/07/21.
//

import UIKit
import RxSwift
import SwiftyJSON
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
    private let disposeBag = DisposeBag()
    var hidden = true
    var toolBar = UIToolbar()
    private var Timeslotdetail = listcartViewmodel()
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
        Timeslotdetail.Getcartlist()
        createCallBack()
        // Do any additional setup after loading the view.
    }
    
    private func createCallBack() {
        
        
        Timeslotdetail.errorMsg.asObservable().subscribe(onNext:
            {
                [unowned self] (errorMessage) in
              
             //   self.nodataview.isHidden = false
                
        }).disposed(by: disposeBag)
        Timeslotdetail.isSuccess.asObserver()
         .bind{ value in
            
            if   self.Timeslotdetail.DeliveryData == nil{
                self.nodataview.isHidden = false
            } else {
                self.DeliverySlot = self.Timeslotdetail.DeliverySlot
                self.nodataview.isHidden = true
                self.DeliveryData = self.Timeslotdetail.DeliveryData
                self.timeslotdata = self.Timeslotdetail.DeliveryData?[0].slotData ?? []
                self.collectioview.reloadData()
            }
            
        print("sfksfksf",self.Timeslotdetail.DeliveryData)
            let tHeight = self.collectioview.frame.height
            print("sfsfnsf",tHeight / CGFloat(7) - 10)
            print("fsjsfjbsf",tHeight)
            self.Titleheadercont.constant = tHeight / CGFloat(7) - 10
            self.titleheaderview.isHidden = false
            
           
     }.disposed(by: disposeBag)
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
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller  = storyBoard.instantiateViewController(withIdentifier: "PaymentViewController") as! ChangePasswordViewController
        self.navigationController?.pushViewController (controller, animated: false)
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
