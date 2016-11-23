//: Playground - noun: a place where people can play

import UIKit

// normal

let str = "2016-09-13T06:00:35Z"

var dateFormatter = NSDateFormatter()
dateFormatter.timeZone = NSTimeZone.localTimeZone()
dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ" //“HH"大写强制24小时制
var date = dateFormatter.dateFromString(str)


// c function

var atime = tm()
strptime(str.cStringUsingEncoding(NSUTF8StringEncoding)!, "%Y-%m-%dT%H:%M:%S%z", &atime)
atime.tm_isdst = -1
var t = mktime(&atime)
var result = NSDate.init(timeIntervalSince1970: Double(t + NSTimeZone.localTimeZone().secondsFromGMT))


let dis = NSDate().timeIntervalSinceDate(result)

var string = ""

let onehour: NSTimeInterval = 60 * 60

if dis < 0 {
    string = "future"
}
else if dis < onehour && dis >= 0 {
    string = "a few minutes ago"
}
else if dis >= onehour && dis <= onehour * 24 {
    string = "\(Int(floor(dis / onehour))) hour ago"
}
else {
    let bufferSize: UInt = 255
    var buffer = [Int8](count: Int(bufferSize), repeatedValue: 0)
    var timeValue = time_t(result.timeIntervalSince1970)
    let tmValue = localtime(&timeValue)
    strftime(&buffer, Int(bufferSize), "%d %B, %Y", tmValue)
    string = String(CString: buffer, encoding: NSUTF8StringEncoding)!
}


