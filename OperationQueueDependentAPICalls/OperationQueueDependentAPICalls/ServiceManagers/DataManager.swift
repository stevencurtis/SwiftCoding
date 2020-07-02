//
//  DataManager.swift
//  OperationQueueDependentAPICalls
//
//  Created by Steven Curtis on 10/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

class DataManager {
    private let queueManager: QueueManager
    init(withQueueManager queueManager: QueueManager = QueueManager.sharedInstance) {
        self.queueManager = queueManager
    }
    
    func retrieveUserListThenUser(completionBlock: @escaping (UserModel?) -> Void) {
        guard let userListURL = URL(string: Constants.baseURL + "?page=2") else { return }
        let fetchList = UserListRetrievalOperation(url: userListURL, httpManager: HTTPManager(session: URLSession.shared))
        let parseList = UserListDecodeOperation()
        let fetchUser = UserRetrievalOperation(url: nil, httpManager: HTTPManager(session: URLSession.shared))
        
        let parseUser = UserDecodeOperation()
        
        // use an adapter to pass the data from fetch to parse
        // unowned since the reference will never become nil
        let adapterList = BlockOperation() { [unowned fetchList, unowned parseList] in
            parseList.dataFetched = fetchList.dataFetched
            parseList.error = fetchList.error
        }
        
        adapterList.addDependency(fetchList)
        parseList.addDependency(adapterList)
        
        let secondAdapterList = BlockOperation() { [unowned parseList, unowned fetchUser] in
            fetchUser.error = parseList.error
            fetchUser.url = parseList.decodedURL
        }
        
        secondAdapterList.addDependency(parseList)
        fetchUser.addDependency(secondAdapterList)

        parseUser.completionHandler = {data in
            completionBlock(data)
        }
        
        let thirdAdapterList = BlockOperation() { [unowned fetchUser, unowned parseUser] in
            parseUser.error = fetchUser.error
            parseUser.dataFetched = fetchUser.dataFetched
        }
        
        thirdAdapterList.addDependency(fetchUser)
        parseUser.addDependency(thirdAdapterList)
        
        queueManager.addOperations([fetchList, parseList, adapterList, fetchUser, secondAdapterList, parseUser, thirdAdapterList])
    }
    
    func retrieveUserList(completionBlock: @escaping (ListUsersModel?) -> Void) {
        guard let url = URL(string: Constants.baseURL + "?page=2") else {return}
        let fetch = UserListRetrievalOperation(url: url, httpManager: HTTPManager(session: URLSession.shared))
        let parse = UserListDecodeOperation()

        // use an adapter to pass the data from fetch to parse
        let adapter = BlockOperation() { [unowned fetch, unowned parse] in
            parse.dataFetched = fetch.dataFetched
            parse.error = fetch.error
        }
        
        adapter.addDependency(fetch)
        parse.addDependency(adapter)
                
        parse.completionHandler = {data in
            completionBlock(data)
        }
        queueManager.addOperations([fetch, parse, adapter])
    }
}
