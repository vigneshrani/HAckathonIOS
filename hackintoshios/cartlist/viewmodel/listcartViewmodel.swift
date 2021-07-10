//
//  File.swift
//  hackintoshios
//
//  Created by vignesh on 10/07/21.
//

import Foundation
//
//  TimeSlotViewModel.swift
//  RetailEcoSs
//
//  Created by vignesh on 24/05/21.
//



import Foundation
import RxSwift
import SwiftyJSON
class TimeSlotViewModel {
    
    
    private let disposeBag = DisposeBag()
    let isLoading = PublishSubject<Bool>()
    let errorMsg = PublishSubject<String>()
    let isSuccess = PublishSubject<Bool>()
    var shoplistmodel: ShopListModel?
    var Customer_Id : Int?
    var status : TimeSlotStatus?
    var DeliverySlot:DeliverySlot?
    var DeliveryData:[DeliveryDatum]?
    func Getcartlist(){
        var params:JSON = JSON()
        let headers : [String: String] = [
            "Content-Type": "application/json",
            //  "Authorization": "jwt \(UserDefaults.standard.getAccessToken())",
           // "TokenNo": "cce618086bfccd93b47dd9d4cf06f52778515b5d"
        ]
        print("sfksfknsf",Shopid)
       
      
        HttpUtils().makeRequest(url: APIList().getUrlString(url: "http://139.59.37.241:3009/order/summary"), method: .POST, parameter: String(describing: params), authorization: headers).observe(on: MainScheduler.instance).subscribe(
            
            onNext:
                {
                    result in
                    self.isLoading.onNext(false)
                    self.process(data: result)
                   

                    print("sfnksfnk",result)
                },
            onError:
                {
                    error in
                    self.isLoading.onNext(false)
                    self.errorMsg.onNext(error.localizedDescription)
                },
            onCompleted:
                {
                }).disposed(by: disposeBag)
    }
    
    func process(data: Data) {
        
        
        if let dataModel = cartlistModel.init(data: data) {
           // shoplistmodel = MyStoreSearchCategoryModel.init(data: data)
            
//            print("fksnnsf",DeliveryData)
            self.isSuccess.onNext(true)
        } else {
            self.isSuccess.onNext(false)
        }
        
}
}

