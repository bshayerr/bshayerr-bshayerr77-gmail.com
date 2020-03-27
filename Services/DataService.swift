//
//  DataService.swift
//  Madad
//
//  Created by bshayer  on 1/27/18.
//  All rights reserved.
//

import Foundation
class DataService {
    
    //to hold all the data of the app
    static let instance = DataService()
    
                      ///// <<< DATA OF JOBS TABLE VIEW >>> /////
    
    private let jobsArray = [
        Jobs(jobName:"Programmer", jobProvider:"GeekLoop", jobImage: "FemaleIcon", catg: .fem ),
        Jobs(jobName:"Designer", jobProvider:"GeekLoop", jobImage: "MaleIcon", catg: .mal),
        Jobs(jobName:"Developer", jobProvider:"GeekLoop", jobImage: "FemaleIcon", catg: .fem), ]


    
                     ///// <<< DATA OF JOBS DETAILS TABLE VIEW >>> /////
    
    private let DetailsArray1 = [
        JobsDetails(TitleLbl: "Job Title:",  ContentLbl: "Programmer"),
        JobsDetails(TitleLbl: "Job Provider:",  ContentLbl: "GeekLoop"),
        JobsDetails(TitleLbl: "Job Requirements:",  ContentLbl: "Certificate degree with considerable work experience"),
        JobsDetails(TitleLbl: "Contact Information:",  ContentLbl: "+966 55 123 4321"),]
    
    
    private let DetailsArray2 = [
        JobsDetails(TitleLbl: "Job Title:",  ContentLbl: "Designer"),
        JobsDetails(TitleLbl: "Job Provider:",  ContentLbl: "GeekLoop"),
        JobsDetails(TitleLbl: "Job Requirements:",  ContentLbl: "Certificate degree in Graphic Desgin"),
        JobsDetails(TitleLbl: "Contact Information:",  ContentLbl: "+966 55 123 4321"),]
    
    private let DetailsArray3 = [
        JobsDetails(TitleLbl: "Job Title:",  ContentLbl: "Developer"),
        JobsDetails(TitleLbl: "Job Provider:",  ContentLbl: "GeekLoop"),
        JobsDetails(TitleLbl: "Job Requirements:",  ContentLbl: "Certificate degree in Apps Development"),
        JobsDetails(TitleLbl: "Contact Information:",  ContentLbl: "+966 55 123 4321"),]
    

    
    
                       ///// <<< DATA OF PLACES TABLE VIEW >>> /////
    
    private let placesArray = [
        Places(placeName: "Almousa Clinic", placeImage: "hospital" ),
        Places(placeName: "AlMahfal", placeImage: "park"),
        Places(placeName: "Alrajhi", placeImage: "bank"),
        Places(placeName: "Ladoucer", placeImage: "restu"), ]
    
    
    
    
    
                        ///// <<< FUNCTIONS TO RETURN THE DATA >>> /////
    
    func getJobs() -> [Jobs] { return jobsArray }
    
    func getPlaces() -> [Places] { return placesArray }
    
    func getJobDetails1()-> [JobsDetails] { return DetailsArray1  }
    
    func getJobDetails2()-> [JobsDetails] { return DetailsArray2 }
    
     func getJobDetails3()-> [JobsDetails] { return DetailsArray3 }
    
    func getJobDetails(forJobsName jobName: String) -> [JobsDetails] {
        switch jobName {
        case "Programmer" :
           return  DetailsArray1
        case "Designer" :
           return  DetailsArray2
        case "Developer" :
            return  DetailsArray3
        default :
          return  DetailsArray1
        }
    }
  
}



