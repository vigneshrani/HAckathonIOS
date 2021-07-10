//
//  cartlist.swift
//  hackintoshios
//
//  Created by vignesh on 10/07/21.
//

import Foundation

// MARK: - Welcome
struct cartlistModel: Codable {
    let error: Bool?
    let message: String?
    let orderItems: [OrderItem]?
    let orderTotal: OrderTotal?
    init?(data: Data)
    {
    do
    {
        let jsonDecoder = JSONDecoder()
        let decode = try jsonDecoder.decode(cartlistModel.self, from: data)
        self = decode
    } catch {
        return nil
    }
}

// MARK: - OrderItem
struct OrderItem: Codable {
    let orderID, itemID: Int?
    let itemName: String?
    let itemQuantity, itemPrice: Int?
    let itemImage: String?

    enum CodingKeys: String, CodingKey {
        case orderID = "orderId"
        case itemID = "itemId"
        case itemName, itemQuantity, itemPrice, itemImage
    }
    init?(data: Data)
    {
        do
        {
            let jsonDecoder = JSONDecoder()
            let decode = try jsonDecoder.decode(OrderItem.self, from: data)
            self = decode
        } catch {
            return nil
        }
    }
}

// MARK: - OrderTotal
struct OrderTotal: Codable {
    let itemTotal, discount, toPay: Int?
}
}
