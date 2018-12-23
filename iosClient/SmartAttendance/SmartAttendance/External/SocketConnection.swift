//
//  SocketConnection.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23.12.2018.
//  Copyright © 2018 Anadolu Sigorta. All rights reserved.
//

import Foundation
import SystemConfiguration.CaptiveNetwork
protocol SocketDelegate: class {
    func receivedMessage(message: String)
}
class SocketConnector: NSObject {
    weak var delegate: SocketDelegate?
    var inputStream: InputStream!
    var outputStream: OutputStream!
    var username = ""
    let maxReadLength = 1024
    //1) Set up the input and output streams for message sending
    func setupNetworkCommunication() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        CFStreamCreatePairWithSocketToHost( kCFAllocatorSystemDefault ,
                                            "ec2-35-156-233-76.eu-central-1.compute.amazonaws.com" as CFString,
                                            5056,
                                            &readStream,
                                            &writeStream)
        
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        
        inputStream.delegate = self
        outputStream.delegate = self
        
        inputStream.schedule(in: .main, forMode: .commonModes)
        outputStream.schedule(in: .main, forMode: .commonModes)
        inputStream.open()
        outputStream.open()
    }
    func sessionStarter(){
        let x = "start_session;\(getWIFIInformation())\n"
        let data = x.data(using: .ascii)!
        _ = data.withUnsafeBytes { outputStream.write($0, maxLength: data.count) }
    }
    func sessionFinisher(){
        let x = "finish_session\n"
        let data = x.data(using: .ascii)!
        _ = data.withUnsafeBytes { outputStream.write($0, maxLength: data.count) }
    }
    func getList(){
        let x = "get_list\n"
        let data = x.data(using: .ascii)!
        _ = data.withUnsafeBytes { outputStream.write($0, maxLength: data.count) }
    }
    func attend(id:String){
        guard let sd = getWiFiAddress() else{
            return
        }
        let x = "attend;\(getWIFIInformation());\(sd);\(id)\n"
        let data = x.data(using: .ascii)!
        _ = data.withUnsafeBytes { outputStream.write($0, maxLength: data.count) }
    }
    
    func stopChatSession() {
        inputStream.close()
        outputStream.close()
    }
    private func getWiFiAddress() -> String? {
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        return address
    }
    func getWIFIInformation() -> String{
        let informationArray:NSArray? = CNCopySupportedInterfaces()
        if let information = informationArray {
            let dict:NSDictionary? = CNCopyCurrentNetworkInfo(information[0] as! CFString)
            if let temp = dict {
                return temp["BSSID"] as! String
            }
        }
        
        return ""
    }
}

extension SocketConnector: StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case Stream.Event.hasBytesAvailable:
            
            readAvailableBytes(stream: aStream as! InputStream)
        case Stream.Event.endEncountered:
            stopChatSession()
        case Stream.Event.errorOccurred:
            print("error occurred")
        case Stream.Event.hasSpaceAvailable:
            print("has space available")
        //readAvailableBytes(stream: aStream as! InputStream)
        case Stream.Event.openCompleted:
            //print("open finished")
            break
        default:
            print("some other event...")
            break
        }
    }
    
    private func readAvailableBytes(stream: InputStream) {
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
        
        while stream.hasBytesAvailable {
            let numberOfBytesRead = inputStream.read(buffer, maxLength: maxReadLength)
            
            if numberOfBytesRead < 0 {
                if let _ = inputStream.streamError {
                    break
                }
            }
            if let message = String(bytesNoCopy: buffer,length: numberOfBytesRead,encoding: .ascii,freeWhenDone: true){
//                print(message)
                if(message.first == "u"||message.first == "\n"){
                    
                }else{
                    
                    let x = message.components(separatedBy: "\n")
                    if (x.count > 2 ){
                        for item in x {
                            if(item == "\n"){
                                
                            }else{
                                delegate?.receivedMessage(message: "\(item)\n")
                            }
                        }
                    }else{
                        delegate?.receivedMessage(message: message)
                    }
                }
                
                
                
            }else{
                print("olmuyor olmuyor")
            }
            
            
        }
    }
}

