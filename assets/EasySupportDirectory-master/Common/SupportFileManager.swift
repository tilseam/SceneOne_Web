//
//  Created by Jon Worms on 8/12/15.
//  Copyright Â© 2015 Off The Farm. All rights reserved.
//

import Foundation


///
/// Objects that implement this protocol are able to be saved to the designated directory in the Application Support directory
///
protocol SupportFile: NSSecureCoding {
    static var fileTypeSubdirectoryName: String { get }
    static var fileTypeExtension: String { get }
    var fileName: String { get }
}





///
/// This class is a singleton. It is used to load and save files that implement the SatelliteFile protocol.
/// The files are all saved to sub directories in the Application Support Directory
///
class SupportFileManager {
    
    
    private static let fileManager: FileManager = FileManager.default
    
    /// gets the running applications name, used for Application Support Directory organization
    private static var applicationName: String {
        if _appName == nil {
            _appName = (Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String)
        }
        return _appName!
        
    }
    private static var _appName: String?
    
    ///
    /// returns a subdirectory for the application in the Application Support Directory
    /// saving files to the top level in the ASD is probably bad taste
    ///
    private static var _asSubdirectory: URL?
    private static func getApplicationSupportDirectory() throws -> URL {
        if _asSubdirectory == nil {
            let asd = try fileManager.url(for: FileManager.SearchPathDirectory.applicationSupportDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            
            // append application name as path component to give the application it's own folder in the ASD
            _asSubdirectory = asd.appendingPathComponent(applicationName)
        }
        return _asSubdirectory!
    }
    
    
    ///
    /// Loads (and if needed, creates) the applictiaon support sub-directory for the application
    ///
    private static func loadFileTypeDirectory(_ fileTypeSubdirectoryName: String) throws -> URL {
        let fileTypeSubdirectory: URL = try getApplicationSupportDirectory().appendingPathComponent(fileTypeSubdirectoryName)
        try fileManager.createDirectory(at: fileTypeSubdirectory, withIntermediateDirectories: true, attributes: nil)
        return fileTypeSubdirectory
    }
    
    
    
    ///
    /// Saves each to its proper position in the application support directory
    ///
    static func saveFiles<T:SupportFile>(files: [T]) throws {
        for file in files {
            try saveFile(file: file)
        }
    }
    
    
    ///
    /// Saves the argument file to the Application Support directy with the file name supplied in it's fileName variable
    ///
    static func saveFile<T:SupportFile>(file: T) throws {
        let fileTypeDir: URL = try loadFileTypeDirectory(T.fileTypeSubdirectoryName)
        let fileURL: URL = fileTypeDir.appendingPathComponent("\(file.fileName).\(T.fileTypeExtension)")
        NSKeyedArchiver.archiveRootObject(file, toFile: fileURL.path)
    }
    
    
    
    ///
    /// Loads a file of the return type with the argument name, if the file does not exist, returns nil
    ///
    static func loadFile<T:SupportFile>(_ name: String) -> T? {
        guard let fileDirPath: URL = try? loadFileTypeDirectory(T.fileTypeSubdirectoryName) else { return nil }
        let filePath = fileDirPath.appendingPathComponent("\(name).\(T.fileTypeExtension)")
        guard let file: T = NSKeyedUnarchiver.unarchiveObject(withFile: filePath.path) as? T else { return nil }
        return file
    }
    
    
    
    ///
    /// Loads all files of the return type from their respective Application Support subdirectory
    ///
    static func loadFiles<T:SupportFile>() -> [T] {
        guard let fileDirPath: URL = try? loadFileTypeDirectory(T.fileTypeSubdirectoryName) else { return [] }
        guard let urlsForFiles: [URL] = try? fileManager.contentsOfDirectory(at: fileDirPath, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles) else { return []}
        
        var files: [T] = []
        for url in urlsForFiles {
            if let file: T = NSKeyedUnarchiver.unarchiveObject(withFile: url.path) as? T {
                files.append(file)
            }
        }
        return files
    }
    
    
    ///
    /// Deletes the argument file from disk
    ///
    static func deleteFile<T:SupportFile>(_ file: T) {
        guard let typeSubdir: URL = try? loadFileTypeDirectory(T.fileTypeSubdirectoryName) else { return }
        let fileURL: URL = typeSubdir.appendingPathComponent("\(file.fileName).\(T.fileTypeExtension)")
        if fileManager.fileExists(atPath: fileURL.path) {
            try? fileManager.removeItem(atPath: fileURL.path)
        }
    }
    
}// end of class

