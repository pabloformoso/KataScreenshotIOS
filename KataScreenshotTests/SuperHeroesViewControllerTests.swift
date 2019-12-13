//
//  SuperHeroesViewControllerTests.swift
//  KataSuperHeroes
//
//  Created by Sergio Gutiérrez on 22/12/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import UIKit
@testable import KataScreenshot

class SuperHeroesViewControllerTests: ScreenshotTest {

    fileprivate let repository = MockSuperHeroesRepository()

    func testShowsEmptyCase() {
        givenThereAreNoSuperHeroes()
        let viewController = getSuperHeroViewController()
        verify(viewController: viewController)
    }
    
    
    func testSomeSuperHeroesAreShown() {
        _ = givenThereAreSomeSuperHeroes()
        let viewController = getSuperHeroViewController()
        verify(viewController: viewController)
    }
    
    
    func testSomeAvengersAreShown() {
        _ = givenThereAreSomeAvengers()
        let viewController = getSuperHeroViewController()
        verify(viewController: viewController)
    }
    
    
    func testOneHeroIsShown() {
        _ = givenThereAreSomeSuperHeroes(1)
        let viewController = getSuperHeroViewController()
        verify(viewController: viewController)
    }
    
    
    func testOneAvengerIsShown() {
        _ = givenThereAreSomeSuperHeroes(1, avengers: true)
        let viewController = getSuperHeroViewController()
        verify(viewController: viewController)
    }
    
    func testHeroWithEmptyName() {
        _ = givenThereAreSomeEmptySuperHeroes()
        let viewController = getSuperHeroViewController()
        verify(viewController: viewController)
    }
    
    func testHeroWithReallyLongName() {
        _ = givenThereAreSomeLongSuperHeroes(1)
        let viewController = getSuperHeroViewController()
        verify(viewController: viewController)
    }
    
    func testAvengengerHeroWithReallyLongName() {
        _ = givenThereAreSomeLongSuperHeroes(1, avengers: true)
        let viewController = getSuperHeroViewController()
        verify(viewController: viewController)
    }
    
    
    fileprivate func givenThereAreSomeAvengers() -> [SuperHero] {
        return givenThereAreSomeSuperHeroes(avengers: true)
    }

    fileprivate func givenThereAreNoSuperHeroes() {
        _ = givenThereAreSomeSuperHeroes(0)
    }

    
    fileprivate func givenThereAreSomeSuperHeroes(_ numberOfSuperHeroes: Int = 10, avengers: Bool = false) -> [SuperHero] {
        var superHeroes = [SuperHero]()
        
        for i in 0..<numberOfSuperHeroes {
            let superHero = SuperHero(name: "SuperHero - \(i)", photo: URL(string: ""), isAvenger: avengers, description: "Description - \(i)")
            superHeroes.append(superHero)
        }
        
        repository.superHeroes = superHeroes
        return superHeroes
    }
    
    fileprivate func givenThereAreSomeEmptySuperHeroes(_ numberOfSuperHeroes: Int = 10, avengers: Bool = false) -> [SuperHero] {
        var superHeroes = [SuperHero]()
        
        for _ in 0..<numberOfSuperHeroes {
            let superHero = SuperHero(name: "", photo: URL(string: ""), isAvenger: avengers, description: "")
            superHeroes.append(superHero)
        }
        
        repository.superHeroes = superHeroes
        return superHeroes
    }
    
    fileprivate func givenThereAreSomeLongSuperHeroes(_ numberOfSuperHeroes: Int = 10, avengers: Bool = false) -> [SuperHero] {
        var superHeroes = [SuperHero]()
        
        for i in 0..<numberOfSuperHeroes {
            let superHero = SuperHero(name: "\(i) - SuperHero SuperHero Super He r o Supe r He r oSu pe r H", photo: URL(string: ""), isAvenger: avengers, description: "SuperHeroSuperHeroSuperHeroSuperHeroSuperHeroSuperHeroSuperHeroSuperHeroSuperHeroSuperHero")
            superHeroes.append(superHero)
        }
        
        repository.superHeroes = superHeroes
        return superHeroes
    }

    fileprivate func getSuperHeroViewController() -> UIViewController {
        let superHeroesViewController = ServiceLocator().provideSuperHeroesViewController() as! SuperHeroesViewController
        superHeroesViewController.presenter = SuperHeroesPresenter(ui: superHeroesViewController, getSuperHeroes: GetSuperHeroes(repository: repository))

        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [superHeroesViewController]

        return rootViewController
    }
}
