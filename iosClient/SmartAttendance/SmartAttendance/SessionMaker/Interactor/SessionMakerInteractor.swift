//
//  SessionMakerSessionMakerInteractor.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

// After filling the InteractorInput and InteractorOutput classes, this class must be filled by the programmer.
import SystemConfiguration.CaptiveNetwork
import Foundation
class SessionMakerInteractor: SessionMakerInteractorInput{


    weak var output: SessionMakerInteractorOutput!
    lazy var socket:SocketConnector = SocketConnector()
    func fetchData() {
        socket.setupNetworkCommunication()
        socket.delegate = self
    }
    func setupSession() {
        if getWIFIInformation() == nil{
            output.wifiCheck()
        }else{
            socket.sessionStarter()
        }
        
        
    }
    func finishSession(){
        socket.sessionFinisher()
    }
    func getWIFIInformation() -> String?{
        let informationArray:NSArray? = CNCopySupportedInterfaces()
        if let information = informationArray {
            let dict:NSDictionary? = CNCopyCurrentNetworkInfo(information[0] as! CFString)
            if let temp = dict {
                return temp["BSSID"] as! String
            }
        }
        
        return nil
    }
}
extension SessionMakerInteractor:SocketDelegate{
    func receivedMessage(message: String) {
        print(message)
        if (message == "Session started successfully\n"){
            output.sessionStartPopUp(isStarted: true)
            
        }
        if message.count > 0{
            let list = message.components(separatedBy: ";")
            output.nextView(list:list)
        }else{
            
        }
    }
}
