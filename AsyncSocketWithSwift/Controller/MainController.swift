import Foundation
import UIKit

class MainController: UIViewController,UITextFieldDelegate,AsyncSocketDelegate {
    
    var asyncSocket = AsyncSocket()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayColor()
        
        self.asyncSocket = AsyncSocket(delegate: self)
        var error:NSError?
        self.asyncSocket.connectToHost("127.0.0.1", onPort:5000, withTimeout:2, error:&error)
        
        if error != nil {
            println(error)
        }
        else{
            println("連線成功")
        }
        
        let open_Button : UIButton! = UIButton(frame: CGRectMake(10, 50, 100, 30))
        open_Button.setTitle("SentData", forState: UIControlState.Normal)
        open_Button.addTarget(self, action: Selector("testOpen"), forControlEvents: UIControlEvents.TouchDown)
        view.addSubview(open_Button)
        
        let close_Button : UIButton! = UIButton(frame: CGRectMake(100, 50, 130, 30))
        close_Button.setTitle("RecieveData", forState: UIControlState.Normal)
        close_Button.addTarget(self, action: Selector("testClose"), forControlEvents: UIControlEvents.TouchDown)
        view.addSubview(close_Button)
    }
    
    func testOpen(){
        let data:NSData! = ("1" as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        self.asyncSocket.writeData(data, withTimeout:-1, tag: 0)
    }
    func testClose(){
        let data:NSData! = ("2" as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        self.asyncSocket.writeData(data, withTimeout:-1, tag: 0)
    }
    
    func onSocket(sock: AsyncSocket!, didWriteDataWithTag tag: Int) {
        println("WriteData")
    }
    
    func onSocket(sock: AsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        println("Info___didReadData")
        self.asyncSocket.readDataWithTimeout(-1, tag: 0)
    }
    
    func onSocket(sock: AsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        println("Info___didConnectToHost")
        self.asyncSocket.readDataWithTimeout(-1, tag: 0)
    }
    
    func onSocket(sock: AsyncSocket!, willDisconnectWithError err: NSError!) {
        println("Info___willDisconnectWithError")
        println("test")
    }
    
}

 