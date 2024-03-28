//
//  CDDataModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 28.03.24.
//

import Foundation
import CoreData

class CDDataModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var saveBreakfastEntity: [BreakfastEntity] = []
    @Published var saveLunchEntity: [LunchEntity] = []
    @Published var saveValueEntity: [ValueEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "CDFoodclass")
        container.loadPersistentStores { (descrip,error) in
            if let error = error {
                print("error loading Data \(error)")
            }
        }
        fetchData()
    }
    
    func fetchData() {
        let requestBreakfast = NSFetchRequest<BreakfastEntity>(entityName: "BreakfastEntity")
        let requestLunch = NSFetchRequest<LunchEntity>(entityName: "LunchEntity")
        let requestValue = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        
        do {
            saveBreakfastEntity = try container.viewContext.fetch(requestBreakfast)
            saveLunchEntity = try container.viewContext.fetch(requestLunch)
            saveValueEntity = try container.viewContext.fetch(requestValue)
        }
        catch let error {
            print("\(error)")
        }
    }
    
    func addBreakfast(icon: String, name: String, ingredients: String, fat: CGFloat, protein: CGFloat, cards: CGFloat) {
        let newBreakfastMeal = BreakfastEntity(context: container.viewContext)
        newBreakfastMeal.icon = icon
        newBreakfastMeal.name = name
        newBreakfastMeal.ingredients = ingredients
        newBreakfastMeal.fat = Float(fat)
        newBreakfastMeal.protein = Float(protein)
        newBreakfastMeal.cards = Float(cards)
        saveData()
    }
    func addLunch(icon: String, name: String, ingredients: String, fat: CGFloat, protein: CGFloat, cards: CGFloat) {
        let newBreakfastMeal = LunchEntity(context: container.viewContext)
        newBreakfastMeal.icon = icon
        newBreakfastMeal.name = name
        newBreakfastMeal.ingredients = ingredients
        newBreakfastMeal.fat = Float(fat)
        newBreakfastMeal.protein = Float(protein)
        newBreakfastMeal.cards = Float(cards)
        saveData()
    }
    func addValue(fat: CGFloat, protein: CGFloat, cards: CGFloat) {
        let newValue = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        
        do {
            let results = try container.viewContext.fetch(newValue)
            if let entity = results.first {
                entity.fat += Float(fat)
                entity.protein += Float(protein)
                entity.cards += Float(cards)
            } else {
                let newValue = ValueEntity(context: container.viewContext)
                newValue.fat = Float(fat)
                newValue.protein = Float(fat)
                newValue.cards = Float(fat)
            }
            saveData()
            fetchData()
        } catch {
            print("\(error)")
        }
    }
    func addRingCalories(calories: CGFloat) {
        let newcal =  NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        
        do {
            let results = try container.viewContext.fetch(newcal)
            if let entity = results.first {
                entity.ring += Float(Int(calories))
            }
            
        }
        catch {
            print("\(error)")
        }
        saveData()
        fetchData()
    }
    func addMealTaggle(meal: BreakfastEntity) {
        meal.addmale.toggle()
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchData()
        } catch {
            print("save Data Failed \(error)")
        }
    }
}
