import Foundation
import UIKit

@objc(ScreenshotDetector)
class ScreenshotDetector: CDVPlugin {

  var callbackId: String?

  override func pluginInitialize() {
    NotificationCenter.default.addObserver(self, selector: #selector(userDidTakeScreenshot), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
  }

  @objc func userDidTakeScreenshot() {
    guard let callbackId = callbackId else { return }

    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "screenshot_taken")
    pluginResult?.setKeepCallbackAs(true)
    self.commandDelegate.send(pluginResult, callbackId: callbackId)
  }

  @objc(startListening:)
  func startListening(command: CDVInvokedUrlCommand) {
    self.callbackId = command.callbackId

    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "listening_started")
    pluginResult?.setKeepCallbackAs(true)
    self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
  }
}
