//
//  Practica_AsyncProg_AGGATests.swift
//  Practica_AsyncProg_AGGATests
//
//  Created by Alejandro Alberto Gavira García on 12/3/24.
//

import XCTest
import Combine
import CombineCocoa
import UIKit
import KeychainSwift

@testable import Practica_AsyncProg_AGGA

final class Practica_AsyncProg_AGGATests: XCTestCase {

    func testKeyChain() throws {
        let kc = KeychainSwift()
        XCTAssertNotNil(kc)
        
        let save = kc.set("Test", forKey: "123")
        XCTAssertEqual(save, true)
        
        let value = kc.get("123")
        if let valor = value {
            XCTAssertEqual(valor, "Test")
        }
        
        XCTAssertNoThrow(kc.delete("123"))
    }
    
    func testNetworkLogin() async throws {
        let obj1 = NetworkLogin()
        XCTAssertNotNil(obj1)
        let obj2 = NetworkLoginFake()
        XCTAssertNotNil(obj2)
        
        let tokenFake = await obj2.loginApp(user: "", password: "")
        XCTAssertNotEqual(tokenFake, "")
        
        let token = await obj1.loginApp(user: "lala", password: "papa")
        XCTAssertEqual(token, "")
        
    }
    
    func testLoginFake() async throws {
        let kc = KeychainSwift()
        XCTAssertNotNil(kc)
        
        let obj = LoginUseCaseFake()
        XCTAssertNotNil(obj)
        
        let resp = await obj.validateToken()
        XCTAssertNotEqual(resp, true)
        
        let loginDo = await obj.loginApp(user: "", password: "")
        XCTAssertEqual(loginDo, true)
        
        var jwt = kc.get(ConstantApp.CONST_TOKEN_ID_KC)
        XCTAssertNotEqual(jwt, "")
        
        
        await obj.logout()
        jwt = kc.get(ConstantApp.CONST_TOKEN_ID_KC)
        XCTAssertEqual(jwt, nil)
    }
    
    func testLoginReal() async throws {
        let kc = KeychainSwift()
        XCTAssertNotNil(kc)
        
        kc.set("", forKey: ConstantApp.CONST_TOKEN_ID_KC)
        
        //Caso de uso con repo Fake
        let useCase = LoginUseCase(repo: LoginRepositoryFake())
        XCTAssertNotNil(useCase)
        
        let resp = await useCase.validateToken()
        XCTAssertEqual(resp, false)
        
        let loginDo = await useCase.loginApp(user: "", password: "")
        XCTAssertEqual(loginDo, true)
        
        var jwt = kc.get(ConstantApp.CONST_TOKEN_ID_KC)
        XCTAssertNotEqual(jwt, "")
        
        
        await useCase.logout()
        jwt = kc.get(ConstantApp.CONST_TOKEN_ID_KC)
        XCTAssertEqual(jwt, nil)
    }
    
    //MARK: - Heroes Section
    func testHeroNetwork() async throws {
        let obj1 = NetworkHeroes()
        XCTAssertNotNil(obj1)
        let obj2 = NetworkHeroesFake()
        XCTAssertNotNil(obj2)
        
        let hero2 = await obj2.getHeroes(filter: "")
        XCTAssertNotEqual(hero2, [])
        
        let hero1 = await obj1.getHeroes(filter: "")
        XCTAssertEqual(hero1, [])
    }
    
    func testHeroReal() async throws {
        let kc = KeychainSwift()
        XCTAssertNotNil(kc)
        
        kc.set("", forKey: ConstantApp.CONST_TOKEN_ID_KC)
        
        //Caso de uso con repo Fake
        let useCase = HeroesUseCase(repo: HeroesRepositoryFake())
        XCTAssertNotNil(useCase)
        
        let hero = await useCase.getHeroes(filter: "")
        XCTAssertNotEqual(hero,[])
    }
    
    func testHeroViewModel() async throws {
        let vm = HeroesViewModel(useCase: HeroesUseCaseFake())
        XCTAssertNotNil(vm)
        
        XCTAssertEqual(vm.heroData.count, 2)
    }
    
    func testHeroesUseCase() async throws {
        let useCase = HeroesUseCase(repo: HeroesRepositoryFake())
        XCTAssertNotNil(useCase)
        
        let data = await useCase.getHeroes(filter: "")
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 2)
        
        
    }
    
    func testHeroesCombine() async throws {
        var suscriptor = Set<AnyCancellable>()
        
        let exp = self.expectation(description: "Heroes Get")
        
        let vm = HeroesViewModel(useCase: HeroesUseCaseFake())
        XCTAssertNotNil(vm)
        
        vm.$heroData
            .sink { completion in
                switch completion{
                case .finished:
                    print("Finished")
                }
            } receiveValue: { hero in
                if hero.count == 2 {
                    exp.fulfill()
                }
            }
            .store(in: &suscriptor)
        
        //await self.waitForExpectations(timeout: 5)
        await fulfillment(of: [exp],timeout: 5)

    }
    
    func testHeroes_Data() async throws {
        
        let network = NetworkHeroesFake()
        XCTAssertNotNil(network)
        
        let repo = HeroesRepository(network: network)
        XCTAssertNotNil(repo)
        
        let repo2 = HeroesRepositoryFake()
        XCTAssertNotNil(repo2)
        
        let data = await repo.getHeroes(filter: "")
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 2)
        
        let data2 = await repo.getHeroes(filter: "")
        XCTAssertNotNil(data2)
        XCTAssertEqual(data2.count, 2)
        
    }
    
    func testHeroes_Domain() async throws {
        let model = Heroes(id: UUID(), name: "goku", description: "", favorite: true, photo: "")
        XCTAssertNotNil(model)
        
        XCTAssertEqual(model.name, "goku")
        XCTAssertEqual(model.favorite, true)
    }
    
    func testHeroes_Presentation() async throws {
        let viewModel = HeroesViewModel(useCase: HeroesUseCaseFake())
        XCTAssertNotNil(viewModel)
        
        let view = await HomeViewController(appState: AppState(loginUseCase: LoginUseCaseFake()), viewModel: viewModel)
        XCTAssertNotNil(view)
    }
    
    //MARK: - Transformation
    func testTransformNetwork() async throws {
        let obj1 = NetworkTransforms()
        XCTAssertNotNil(obj1)
        let obj2 = NetworkTransformsFake()
        XCTAssertNotNil(obj2)
        
        let transform2 = await obj2.getTransforms(id: UUID())
        XCTAssertNotEqual(transform2, [])
        
        let transform1 = await obj1.getTransforms(id: UUID())
        XCTAssertEqual(transform1, [])
    }
    
    func testTransformReal() async throws {
        let kc = KeychainSwift()
        XCTAssertNotNil(kc)
        
        kc.set("", forKey: ConstantApp.CONST_TOKEN_ID_KC)
        
        //Caso de uso con repo Fake
        let useCase = TransformUseCase(repo: TransformationRepositoryFake())
        XCTAssertNotNil(useCase)
        
        let transform = await useCase.getTransforms(id: UUID())
        XCTAssertNotEqual(transform,[])
    }
    
    func testTransformViewModel() async throws {
        let vm = TransformViewModel(useCase: TransformUseCaseFake(), hero: Heroes(id: UUID(), name: "", description: "", favorite: false, photo: ""))
        XCTAssertNotNil(vm)
        
        XCTAssertEqual(vm.transformData.count, 2)
    }
    
    func testTransformUseCase() async throws {
        let useCase = TransformUseCase(repo: TransformationRepositoryFake())
        XCTAssertNotNil(useCase)
        
        let transform = await useCase.getTransforms(id: UUID())
        XCTAssertNotNil(transform)
        XCTAssertEqual(transform.count, 2)
        
        
    }
    
    func testTransformCombine() async throws {
        var suscriptor = Set<AnyCancellable>()
        
        let exp = self.expectation(description: "Transformations")
        
        let vm = TransformViewModel(useCase: TransformUseCaseFake(), hero: Heroes(id: UUID(), name: "", description: "", favorite: false, photo: ""))
        XCTAssertNotNil(vm)
        
        vm.$transformData
            .sink { completion in
                switch completion{
                case .finished:
                    print("Finished")
                }
            } receiveValue: { transform in
                if transform.count == 2 {
                    exp.fulfill()
                }
            }
            .store(in: &suscriptor)
        
        //await self.waitForExpectations(timeout: 5)
        await fulfillment(of: [exp],timeout: 5)

    }
    
    func testTransformData() async throws {
        
        let network = NetworkTransformsFake()
        XCTAssertNotNil(network)
        
        let repo = TransformationRepository(network: network)
        XCTAssertNotNil(repo)
        
        let repo2 = TransformationRepositoryFake()
        XCTAssertNotNil(repo2)
        
        let transform1 = await repo.getTransforms(id: UUID())
        XCTAssertNotNil(transform1)
        XCTAssertEqual(transform1.count, 2)
        
        let transform2 = await repo2.getTransforms(id: UUID())
        XCTAssertNotNil(transform2)
        XCTAssertEqual(transform2.count, 2)
        
    }
    
    func testTransformDomain() async throws {
        let model = Transformation(id: UUID(), name: "Vegeto", description: "Mezcla Vegeta Goku pendientes", photo: "", hero: Heroes(id: UUID(), name: "goku", description: "", favorite: true, photo: ""))
        XCTAssertNotNil(model)
        
        XCTAssertEqual(model.name, "Vegeto")
        XCTAssertEqual(model.info, "Mezcla Vegeta Goku pendientes")
    }
    
    func testTransformPresentation() async throws {
        let viewModel = TransformViewModel(useCase: TransformUseCaseFake(), hero: Heroes(id: UUID(), name: "goku", description: "", favorite: true, photo: ""))
        XCTAssertNotNil(viewModel)
        
        let view = await TransformationViewController(appState: AppState(), viewModel: viewModel)
        XCTAssertNotNil(view)
    }
    
}
