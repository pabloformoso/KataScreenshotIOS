//
//  SuperHeroesDetailViewControllerTests.swift
//  KataScreenshotTests
//
//  Created by Pablo Formoso Estrada on 13/12/2019.
//  Copyright © 2019 Karumi. All rights reserved.
//

import UIKit
@testable import KataScreenshot

class SuperHeroesDetailViewControllerTests: ScreenshotTest {

    fileprivate let repository = MockSuperHeroesRepository()


    
    fileprivate func getSuperHeroDetailViewController(name: String) -> UIViewController {
        let superHeroesDetailViewController = ServiceLocator().provideSuperHeroDetailViewController(name) as! SuperHeroDetailViewController
        superHeroesDetailViewController.presenter = SuperHeroesPresenter(ui: superHeroesDetailViewController, getSuperHeroes: GetSuperHeroByName(name))

        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [superHeroesViewController]

        return rootViewController
    }
}
