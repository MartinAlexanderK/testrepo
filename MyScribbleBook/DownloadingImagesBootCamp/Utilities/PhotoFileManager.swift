//
//  PhotoFileManager.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 25.07.23.
//

import Foundation
import SwiftUI

class PhotoFileManager {
    
    static let instance = PhotoFileManager()
    
    private init(){}
    
    
    //MARK: - path functions
    
    func getFolderUrl(folderName: String) -> URL? {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(path: folderName)
    }
    func getImageUrl(folderName: String, imageName : String) -> URL? {
        guard let folderUrl = getFolderUrl(folderName: folderName) else{return nil}
        return folderUrl.appending(path: imageName + ".png")
    }
    //MARK: - created folder if needed function
    
    func createFolderIfNeeded(folderName:String) {
        guard
            let folderUrl = getFolderUrl(folderName: folderName),
            !FileManager.default.fileExists(atPath: folderUrl.path()) else {
            return}
        do {
            try FileManager.default.createDirectory(atPath: folderUrl.path(), withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            print("Error creating new folder: \(error)")
        }
    }
    
    //MARK: - save and get
    
    func saveImage(folderName:String, imageName:String, image: UIImage) {
        createFolderIfNeeded(folderName: folderName)
        guard
            let imageUrl = getImageUrl(folderName: folderName, imageName: imageName),
            let data = image.pngData()
        else {
            return
        }
        do {
            try data.write(to: imageUrl)
        } catch let error {
            print("Error saving image: \(error)")
        }
        
    }
    func getImage(folderName:String, imageName: String) -> UIImage? {
        guard
            let imageUrl = getImageUrl(folderName: folderName, imageName: imageName),
            FileManager.default.fileExists(atPath: imageUrl.path())
        else {
            return nil
        }
        return UIImage(contentsOfFile: imageUrl.path())
    }
}
