//
//  API List.swift
//  RetailEcoSs
//
//  Created by vignesh on 18/05/21.
//

import Foundation



struct APIList {
    
        let BASE_URL = "https://www.retailecoss.com/retailecos/api/"
        let BASE_URL_DEV = "https://www.smartkirana.ca/retailecos/api/"
    
        func getUrlString(url: urlString) -> String {
            return BASE_URL + url.rawValue
        }
    
}

enum urlString: String {
    //MARK: For Student flow
    case validate_OTP = "validateOtp"
    case Fetch_Customer_Profile = "FetchCustomerProfile"
    case Fetch_Customer_Delivery_Address = "FetchCustomerDeliveryAddress"
    case LET_ME_SHOP = "LetmeShop"
    case FETCH_PRODUCT_LIST_CAR = "FetchProductListCAR"
    case Change_Password_Update = "ChangePasswordUpdate"
    case Update_Profile_PicBase_64 = "UpdateProfilePic"
    case FETCH_PRODUCT_LIST_CAS = "FetchProductListCAS"
    case Update_Customer_Profile = "UpdateCustomerProfile"
    case Family_Member_Registration = "FamilyMemberRegistration"
    case Fetch_Delivery_slot = "FetchDeliveryslot"
    case Fetch_Single_Product = "fetchSingleProduct"
    case Fetch_My_Subscription = "fetchmySubscription"
    case Update_Subscription = "UpdateSubscription"
    case Fetch_Loyalty = "fetchLoyalty"
    case Fetch_Customer_Offer = "fetchCustomerOffer"
    case Fetch_Share_App = "fetchshareApp"
    case Update_Customer_Delivery_Address = "UpdateCustomerDeliveryAddress"
    case fetch_Permission = "fetchPermission"
    case update_Permission = "updatePermission"
    case Fetch_Settings = "FetchSettings"
    case Update_Settings = "UpdateSettings"
    case fetchTerms_and_conditions = "fetchTermsandconditions"
    case fetch_Credit_Balance = "fetchCreditBalance"
    case fetch_Myorders = "fetchMyorders"
    case fetch_WishList = "fetchWishList"
    case fetch_Favorite_Product = "fetchFavoriteProduct"
    case Change_Password_OTP_Send = "ChangePasswordOTPSend"
    case Change_Password_OTP_Verify = "ChangePasswordOTPVerify"
    case Update_Profile_OTP_Send = "UpdateProfileOTPSend"
    case UpdateProfileOTPVerify = "UpdateProfileOTPVerify"
    case fetch_Updated_Product_Details = "fetchUpdatedProductDetails"
    case Fetch_Menu_New = "fetchMenuNew"

}
