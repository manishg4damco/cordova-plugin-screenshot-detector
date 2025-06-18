import Foundation
import UIKit

@objc(ScreenshotDetector)
class ScreenshotDetector: CDVPlugin {

  override func pluginInitialize() {
    NotificationCenter.default.addObserver(self, selector: #selector(userDidTakeScreenshot), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
  }

  @objc func userDidTakeScreenshot() {
    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "screenshot_taken")
    pluginResult?.setKeepCallbackAs(true)
    self.commandDelegate.send(pluginResult, callbackId: "screenshot_callback")
  }

  @objc(startListening:)
  func startListening(command: CDVInvokedUrlCommand) {
    self.commandDelegate.send(CDVPluginResult(status: CDVCommandStatus_OK), callbackId: command.callbackId)
  }
}
