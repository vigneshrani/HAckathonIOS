
import Foundation
import RxSwift
import SwiftyJSON

enum HTTPMethod: String
{
    case POST
    case GET
    case PUT
    case DELETE
}

enum ResponseError: Error
{
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}


class HttpUtils
{
    private let urlSession = URLSession.shared
    
    func makeRequest(url: String, method: HTTPMethod, parameter:String, authorization: [String: String]?)-> Observable<Data> {

        return Observable.create
            {
                observer in
                
               
                    guard let components = URLComponents(string: url) else {
                        observer.onError(ResponseError.invalidEndpoint)
                        return Disposables.create()
                    }
                    
                    guard let url = components.url else {
                        observer.onError(ResponseError.invalidEndpoint)
                        return Disposables.create()
                    }
                    

                    var request = URLRequest(url: url)
                    print("Url : ",url)

                    request.httpMethod = method.rawValue
                    if authorization != nil {
                        request.allHTTPHeaderFields = authorization
                    }
                    print("authorization : ",authorization ?? "")

                   
                    request.httpBody = Data(parameter.utf8)
                    
                    print("parameter : ",parameter ?? ["" : ""])

                    self.urlSession.dataTask(with: request) { (data, response, error) in
                        
                        if error != nil {
                            observer.onError(error!)
                            return
                        }
                        
                        guard let data = data else {
                            observer.onError(ResponseError.noData)
                            return
                        }
                        print("response",JSON(data))
                        observer.onNext(data)
                        observer.onCompleted()
                        
                    }.resume()
                return Disposables.create {
                }
        }
    }
    

    /*
    func imageUploadRequest(parameters: [String: String]? = nil, image: UIImage?, url: String, method: HTTPMethod = .POST, mimeType: String = "image/jpg", filename: String = "user-profile.jpg")-> Observable<Data>
    {
        return Observable.create
        {
            observer in

            if Connectivity.isConnectedToInternet()
            {
                
               guard let components = URLComponents(string: url) else
               {
                    observer.onError(ResponseError.invalidEndpoint)
                    return Disposables.create()
               }
               
               guard let url = components.url else
               {
                    observer.onError(ResponseError.invalidEndpoint)
                    return Disposables.create()
               }

                var request = URLRequest(url: url)
                
                request.httpMethod = method.rawValue
//                let boundary = "Boundary-\(NSUUID().uuidString)"
//                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

                let imageData = image?.jpeg(.low)!
                if (imageData == nil) {
                    print("UIImageJPEGRepresentation return nil")
                    observer.onError(ResponseError.invalidEndpoint)
                    return Disposables.create()
                }
                
                print("URL = ",url)

                let body = NSMutableData()
//                let boundaryPrefix = "--\(boundary)\r\n"
                
//                if let params = parameters
//                {
//                    for (key, value) in params {
//                        body.appendString(boundaryPrefix)
//                        body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//                        body.appendString("\(value)\r\n")
//                    }
//                }
//
//                body.appendString(boundaryPrefix)
//                body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
//                body.appendString("Content-Disposition: form-data; name=uploaded_file")
                body.appendString("Content-Type: \(mimeType)\r\n\r\n")
                body.append(imageData!)
//                body.appendString("\r\n")
//                body.appendString("--".appending(boundary.appending("--")))
                request.httpBody = body as Data
                

                let task =  URLSession.shared.dataTask(with: request as URLRequest, completionHandler:
                {
                    (data, response, error) -> Void in
                    
                    if error != nil
                    {
                         observer.onError(error!)
                         return
                    }
                    
                    guard let data = data else
                    {
                         observer.onError(ResponseError.noData)
                         return
                    }
                    
                    observer.onNext(data)
                    observer.onCompleted()
                    
                })

                task.resume()
            }
            else
            {
                let error = NSError(domain: "", code: 4, userInfo: [NSLocalizedDescriptionKey : CONSTANT.CHECK_INTERNET_CONNECTION])
                 observer.onError(error)
            }
            return Disposables.create
            {
            }
        }
    }*/
    

//    func videoUploadRequest(parameters: [String: String]? = nil, image: Data, url: String, method: HTTPMethod = .POST, mimeType: String = "video/mp4", filename: String = "user-profile.mp4")-> Observable<Data>
//    {
//        return Observable.create
//        {
//            observer in
//
//            if Connectivity.isConnectedToInternet()
//            {
//
//               guard let components = URLComponents(string: url) else
//               {
//                    observer.onError(ResponseError.invalidEndpoint)
//                    return Disposables.create()
//               }
//
//               guard let url = components.url else
//               {
//                observer.onError(ResponseError.invalidEndpoint)
//                    return Disposables.create()
//               }
//
//
//
//                // generate boundary string using a unique per-app string
//                let boundary = UUID().uuidString
//
//                let config = URLSessionConfiguration.default
//                let session = URLSession(configuration: config)
//
//                // Set the URLRequest to POST and to the specified URL
////                var urlRequest = URLRequest(url: URL(string: "http://188.166.228.50:3006/uploads/fileUpload")!)
//
//                var urlRequest = URLRequest(url: url)
//                urlRequest.httpMethod = method.rawValue
//
//
//
//                // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
//                // And the boundary is also set here
//                urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//                urlRequest.setValue(".mp4", forHTTPHeaderField: "extension")
//
//
//                var data = Data()
//
//                // Add the image data to the raw http request data
//                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//                data.append("Content-Disposition: form-data; name=\"uploaded_file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
//                data.append("Content-Type: video/mp4\r\n\r\n".data(using: .utf8)!)
//                data.append(image)
//
//                // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
//                // According to the HTTP 1.1 specification https://tools.ietf.org/html/rfc7230
//                data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//
//                // Send a POST request to the URL, with the data we created earlier
//                session.uploadTask(with: urlRequest, from: data, completionHandler:
//                {
//                    data, response, error in
//
//
//                    if error != nil
//                    {
//                         observer.onError(error!)
//                         return
//                    }
//
//                    guard let data = data else
//                    {
//                         observer.onError(ResponseError.noData)
//                         return
//                    }
//
//                    observer.onNext(data)
//                    observer.onCompleted()
//
////
////
////                    if(error != nil){
////                        print("\(error!.localizedDescription)")
////                    }
////
////                    guard let responseData = responseData else {
////                        print("no response data")
////                        return
////                    }
////
////                    if let responseString = String(data: responseData, encoding: .utf8) {
////                        print("uploaded to: \(responseString)")
////                    }
//                }).resume()
//
//            }
//            else
//            {
//                let error = NSError(domain: "", code: 4, userInfo: [NSLocalizedDescriptionKey : CONSTANT.CHECK_INTERNET_CONNECTION])
//                 observer.onError(error)
//            }
//            return Disposables.create
//            {
//            }
//        }
//    }
//
//
    func imageUploadRequest(parameter:[String: String]?, image: UIImage?, url: String, method: HTTPMethod = .POST, mimeType: String = "image/jpg",authorization: [String: String]?, filename: String = "user-profile.jpg")-> Observable<Data>
    {
        return Observable.create
        {
            observer in


               guard let components = URLComponents(string: url) else
               {
                    observer.onError(ResponseError.invalidEndpoint)
                    return Disposables.create()
               }

               guard let url = components.url else
               {
                observer.onError(ResponseError.invalidEndpoint)
                    return Disposables.create()
               }



                // generate boundary string using a unique per-app string
                let boundary = UUID().uuidString

                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)

                // Set the URLRequest to POST and to the specified URL
//                var urlRequest = URLRequest(url: URL(string: "http://188.166.228.50:3006/uploads/fileUpload")!)

                var urlRequest = URLRequest(url: url)
                print("Url : ",url)
                urlRequest.httpMethod = method.rawValue
            if authorization != nil {
                urlRequest.allHTTPHeaderFields = authorization
            }
            print("authorization : ",authorization ?? "")
//            urlRequest.httpBody = Data(parameter.utf8)


                // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
                // And the boundary is also set here
                urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                urlRequest.setValue(".png", forHTTPHeaderField: "extension")

                var data = Data()
                print("sfbknfks",image)
                // Add the image data to the raw http request data
            print("ffsnksf",parameter)
            if parameter != nil {
                for (key, value) in parameter! {
                    data.appendString(string: "--\(boundary)\r\n")
                    data.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    data.appendString(string: "\(value)\r\n")
                }
            }
//                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
////                data.append("Content-Disposition: form-data; name=\"uploaded_file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
//                data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
//                data.append(image!.pngData()!)
//
//                // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
//                // According to the HTTP 1.1 specification https://tools.ietf.org/html/rfc7230
//                data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//            let filename = "\("Profile_Pic").jpg"
//            let mimetype = "image/jpg"
//            let data1 =  image?.pngData()
//          //  data.appendString(string: "--\(boundary)\r\n")
//            data.appendString(string: "Content-Disposition: form-data; name=\"\("file")\"; filename=\"\(filename)\"\r\n")
//            data.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
//            data.append(data1! as Data)
////            data.appendString(string: "\r\n")
//            data.appendString(string: "--\(boundary)--\r\n")
            let imageData = image!.jpegData(compressionQuality: 1)

            let filename = "user-profile.png"

               let mimetype = "image/png"

            data.appendString(string: "--\(boundary)\r\n")
            data.appendString(string: "Content-Disposition: form-data; name=\"\("Profile_Pic")\"; filename=\"\(filename)\"\r\n")
            data.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
            data.append(imageData!)
            data.appendString(string: "\r\n")

            data.appendString(string: "--\(boundary)--\r\n")
                // Send a POST request to the URL, with the data we created earlier
            
           
                session.uploadTask(with: urlRequest, from: data, completionHandler:
                {
                    data, response, error in


                    if error != nil
                    {
                         observer.onError(error!)
                         return
                    }

                    guard let data = data else
                    {
                         observer.onError(ResponseError.noData)
                         return
                    }
                    print("response",JSON(data))
                    observer.onNext(data)
                    observer.onCompleted()

//
//
//                    if(error != nil){
//                        print("\(error!.localizedDescription)")
//                    }
//
//                    guard let responseData = responseData else {
//                        print("no response data")
//                        return
//                    }
//
//                    if let responseString = String(data: responseData, encoding: .utf8) {
//                        print("uploaded to: \(responseString)")
//                    }
                }).resume()

            
            return Disposables.create
            {
            }
        }
    }
//    func FileUploadRequest(parameters: [String: String]? = nil, dataFile: Data?, url: String, method: HTTPMethod = .POST, mimeType: String = "file/pdf", filename: String = "file_upload.pdf")-> Observable<Data>
//    {
//        return Observable.create
//        {
//            observer in
//
//            if Connectivity.isConnectedToInternet()
//            {
//
//               guard let components = URLComponents(string: url) else
//               {
//                    observer.onError(ResponseError.invalidEndpoint)
//                    return Disposables.create()
//               }
//
//               guard let url = components.url else
//               {
//                observer.onError(ResponseError.invalidEndpoint)
//                    return Disposables.create()
//               }
//
//
//
//                // generate boundary string using a unique per-app string
//                let boundary = UUID().uuidString
//
//                let config = URLSessionConfiguration.default
//                let session = URLSession(configuration: config)
//
//                // Set the URLRequest to POST and to the specified URL
////                var urlRequest = URLRequest(url: URL(string: "http://188.166.228.50:3006/uploads/fileUpload")!)
//
//                var urlRequest = URLRequest(url: url)
//                urlRequest.httpMethod = method.rawValue
//
//                urlRequest.httpMethod = method.rawValue
////                if authorization != nil {
////                    urlRequest.allHTTPHeaderFields = authorization
////                }
////                print("authorization : ",authorization ?? "")
//
//                // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
//                // And the boundary is also set here
////                urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
////
////                urlRequest.setValue("pdf; boundary=\(boundary)", forHTTPHeaderField: "extension")
//
//                urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//                urlRequest.setValue(".pdf", forHTTPHeaderField: "extension")
//
//
//                var data = Data()
//
//                // Add the image data to the raw http request data
//                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//                data.append("Content-Disposition: form-data; name=\"uploaded_file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
//                data.append("Content-Type: file/pdf\r\n\r\n".data(using: .utf8)!)
//                data.append(dataFile!)
//
//                // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
//                // According to the HTTP 1.1 specification https://tools.ietf.org/html/rfc7230
//                data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//
//                // Send a POST request to the URL, with the data we created earlier
//                session.uploadTask(with: urlRequest, from: data, completionHandler:
//                {
//                    data, response, error in
//
//
//                    if error != nil
//                    {
//                         observer.onError(error!)
//                         return
//                    }
//
//                    guard let data = data else
//                    {
//                         observer.onError(ResponseError.noData)
//                         return
//                    }
//
//                    observer.onNext(data)
//                    observer.onCompleted()
//
////
////
////                    if(error != nil){
////                        print("\(error!.localizedDescription)")
////                    }
////
////                    guard let responseData = responseData else {
////                        print("no response data")
////                        return
////                    }
////
////                    if let responseString = String(data: responseData, encoding: .utf8) {
////                        print("uploaded to: \(responseString)")
////                    }
//                }).resume()
//
//            }
//            else
//            {
//                let error = NSError(domain: "", code: 4, userInfo: [NSLocalizedDescriptionKey : CONSTANT.CHECK_INTERNET_CONNECTION])
//                 observer.onError(error)
//            }
//            return Disposables.create
//            {
//            }
//        }
//    }

}

extension URLRequest
{
    private func percentEscapeString(_ string: String) -> String {
        var characterSet = CharacterSet.alphanumerics
        characterSet.insert(charactersIn: "-._* ")
        
        return string
            .addingPercentEncoding(withAllowedCharacters: characterSet)!
            .replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
    }
    
    mutating func encodeParameters(parameters: [String : String]) {
        
        let parameterArray = parameters.map { (arg) -> String in
            let (key, value) = arg
            return "\(key)=\(self.percentEscapeString(value))"
        }
        
        httpBody = parameterArray.joined(separator: "&").data(using: String.Encoding.utf8)
    }
}

extension NSMutableData {

    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String, imgKey: String) -> NSData {
        let body = NSMutableData();

        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }

        let filename = "\(imgKey).jpg"
        let mimetype = "image/jpg"

    body.appendString("--\(boundary)\r\n")
    body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
    body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
    body.appendString("\r\n")
    body.appendString("--\(boundary)--\r\n")

        return body
}

func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().uuidString)"
}




