//
//  ClassListClassListInteractor.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

// After filling the InteractorInput and InteractorOutput classes, this class must be filled by the programmer.
import Foundation
class ClassListInteractor: ClassListInteractorInput {
    var messages:[String] = []
    func csvMaker() {
        let date = Date()
        
        let fileName = "Attendance-\(date.formatMaker(formatVersion: "dd.MM.yyyy")).csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = "ID List\n"
        for item in  messages {
            let newLine = "\((item))\n"
            csvText.append(newLine)
        }
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            output.vcMaker(path: path!)
        }catch {
            
            print("Failed to create file")
            print("\(error)")
        }
    }
    
    func socketCloser() {
        socket.stopChatSession()
    }
    
    weak var output: ClassListInteractorOutput!
    lazy var socket:SocketConnector = SocketConnector()
    func fetchData() {
        socket.setupNetworkCommunication()
        socket.delegate = self
        socket.getList()
    }

}
extension ClassListInteractor:SocketDelegate{
    func receivedMessage(message: String) {
        print("\(message)")
        if (message != ""){
            let result = message.components(separatedBy: ";")
            messages = result
            output.attandees(List: result)
        }else{
            output.noResult()
        }
    }
}
