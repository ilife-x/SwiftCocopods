//
//  NetworkTools.swift
//  SwiftCocopods
//
//  Created by wang xiao on 2020/12/13.
//

import UIKit
import AFNetworking

//单例
class NetworkTools: AFHTTPSessionManager {
    
//    static let sharInstanse : NetworkTools = NetworkTools()
    //通过闭包创建对象，可以增加一些通用配置
    static let shareInstanse : NetworkTools = {
        let tools = NetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tools
    }()
}

enum MethodType : String{
    case GET = "GET"
    case POST = "POST"
}

//Mark: - 封装请求方法
extension NetworkTools{
    typealias RequestCallBack  = ((_ result:Any?,_ error:Error?)->())?



    func request(methodType:MethodType,url:String,parameters:Any?, finished: RequestCallBack) {
        
        
        
        let success = {(tarsk:URLSessionDataTask,result: Any?) -> Void in
            finished!(result,nil)
        }
        
        let failure = { (tarsk:URLSessionDataTask?, err:Error?)->Void in
            finished!(nil,err)
        }
        
        
        
        switch methodType {
        case .GET:
            print("###get")
            get(url, parameters: parameters, headers: nil, progress:nil, success: success, failure:failure)
        case .POST:
            print("###post")
            post(url, parameters: parameters, headers: nil, progress: nil, success: success, failure: failure)
        }
        
    

        
        
    }

}
