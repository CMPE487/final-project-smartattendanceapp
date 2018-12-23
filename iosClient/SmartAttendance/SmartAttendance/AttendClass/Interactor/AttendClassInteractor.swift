//
//  AttendClassAttendClassInteractor.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

// After filling the InteractorInput and InteractorOutput classes, this class must be filled by the programmer.
class AttendClassInteractor: AttendClassInteractorInput {
    func attendClass(id: String) {
        socket.attend(id: id)
    }
    weak var output: AttendClassInteractorOutput!
    lazy var socket:SocketConnector = SocketConnector()
    func fetchData() {
        socket.setupNetworkCommunication()
        socket.delegate = self
    }
    func finishSession(){
        socket.sessionFinisher()
    }
}
extension AttendClassInteractor:SocketDelegate{
    func receivedMessage(message: String) {
        print(message)
        if (message != ""){
            output.result(message: message)
        }
    }
}
