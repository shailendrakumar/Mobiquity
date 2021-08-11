
import Foundation

protocol WebServiceDelegate{
    func getResponse(result:Data)
    func getErrorResponse(error:NSString)
}
