//
//  AppDelegate.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/19/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var reachability: Reachability? = Reachability.networkReachabilityForInternetConnection()
    var window: UIWindow?
    var drawerSide:MMDrawerSide = .left
    var centerContainer:MMDrawerController?
    public static let delegate  = UIApplication.shared.delegate as! AppDelegate
    let storyBoard = UIStoryboard(name: Constants.MAIN, bundle: nil)
    public static var delegateInstance:AppDelegate?
    public static var defaultInstance:UserDefaults?
    var headerParams:HTTPHeaders?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        registerDefualts()
        UINavigationBar.appearance().barTintColor = UIColor.purple
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UINavigationBar.appearance().barStyle = .blackTranslucent
        presentInitialVC()
        setObservers()
        return true
    }
    public static func getDelegateInstance() -> AppDelegate{
        if delegateInstance == nil {
            delegateInstance = UIApplication.shared.delegate as? AppDelegate
        }
        return delegateInstance!
    }
    func  getRequestHeader() -> HTTPHeaders {
        if headerParams == nil {
             headerParams = [ConstantsKeyPairs.HEADER_SECRET_KEY: ServerConstants.APP_SECRET_KEY, ConstantsKeyPairs.HEADER_API_KEY: ServerConstants.APP_API_KEY]
        }
        return headerParams!
    }
    public static func getUserDataInstance() -> UserDefaults{
        if defaultInstance == nil {
        defaultInstance = UserDefaults.standard
        }
        return defaultInstance!
    }
    func setObservers()  {
         NotificationCenter.default.addObserver(self, selector: #selector(reachabilityDidChange(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotificationName), object: nil)
    }
    func reachabilityDidChange(_ notification: Notification) {
        checkReachability()
    }
    func checkReachability() {
        guard let r = reachability else { return }
        let vc = (self.window?.rootViewController)!
        if r.isReachable  {
            wifiOrWwlan(r, vc:vc)
        } else {
        }
    }
    func wifiOrWwlan(_ r:Reachability, vc:UIViewController){
        switch r.currentReachabilityStatus {
        case ReachabilityStatus.reachableViaWiFi:
            break
        case ReachabilityStatus.reachableViaWWAN:
            break
        default:
            break
        }
    }
    func presentInitialVC() {
        
        if UserDefaultsData.getBool(DefaultDataConstants.IS_FIRST_TIME){
            let loginVC = self.storyBoard.instantiateViewController(withIdentifier: IdentifierConstants.SB_LOGIN) as! Login
            window?.rootViewController = loginVC
        }else {
            setDrawer()
        }
        
    }
    func registerDefualts() {
        AppDelegate.getUserDataInstance().register(defaults: [DefaultDataConstants.IS_FIRST_TIME : true])
        AppDelegate.getUserDataInstance().register(defaults: [DefaultDataConstants.IS_USER_LOGIN : false])
        AppDelegate.getUserDataInstance().register(defaults: [DefaultDataConstants.USER_NAME : Constants.EMPTY_STRING])
        AppDelegate.getUserDataInstance().register(defaults: [DefaultDataConstants.USER_EMAIL : Constants.EMPTY_STRING])
        AppDelegate.getUserDataInstance().register(defaults: [DefaultDataConstants.USER_TOKEN : Constants.EMPTY_STRING])
        AppDelegate.getUserDataInstance().register(defaults: [DefaultDataConstants.USER_PHONE : Constants.EMPTY_STRING])
        AppDelegate.getUserDataInstance().register(defaults: [DefaultDataConstants.USER_PIC : Constants.EMPTY_STRING])
        AppDelegate.getUserDataInstance().register(defaults: [DefaultDataConstants.PROFILE_PERCENTAGE : Constants.VALUE_ZERO_INT])


    }
    func setDrawer()  {
        let centerViewController = self.storyBoard.instantiateViewController(withIdentifier: Constants.VIEW_CONTROLLER) as! ViewController
        let leftViewController = self.storyBoard.instantiateViewController(withIdentifier: Constants.NAVIGATION_DRAWER) as! NavigationDrawerVC
        let leftDrawer = UINavigationController(rootViewController: leftViewController)
        let center = UINavigationController(rootViewController: centerViewController)
       centerContainer =  MMDrawerController(center: center, leftDrawerViewController: leftDrawer)
        centerContainer!.openDrawerGestureModeMask=MMOpenDrawerGestureMode.panningCenterView
        centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
        window!.rootViewController=centerContainer
        window!.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Offer_Brite")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

