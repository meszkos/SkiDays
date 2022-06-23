//
//  VideoPicker.swift
//  SkiDays
//
//  Created by MacOS on 05/06/2022.
//

import SwiftUI
import Firebase
import FirebaseStorage
import AVFoundation
import MobileCoreServices

struct VideoPicker: UIViewControllerRepresentable{

    @Binding var video: UIImage
    
    
    func makeUIViewController(context: Context) -> UIImagePickerController {


        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.mediaTypes = ["public.movie"]
        
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context){}

    func makeCoordinator() -> Coordinator {
        return Coordinator(videoPicker: self)
    }

    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        
        let videoPicker: VideoPicker
        
        init(videoPicker: VideoPicker){
            self.videoPicker = videoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL{
                //print(videoURL, "file url")
                let filename = "someFilename.mov"
                
                Storage.storage().reference().child(filename).putFile(from: videoURL as URL, metadata: nil, completion: {(metadata, error) in
                    if error != nil {
                        print("failed uploading video:", error)
                    }
                    if let storageURL = metadata?.storageReference?.downloadURL{
                        print(storageURL)
                    }
                    
                })
                
            }
            
            picker.dismiss(animated: true)
        }

    }
    
}


