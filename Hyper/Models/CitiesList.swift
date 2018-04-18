//
//  CitiesList.swift
//  Hyper
//
//  Created by admin on 4/18/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit

enum Cities  : Int {
    private func isAr() -> Bool {
        return   L102Language.currentAppleLanguage() == "ar"
    }
    case Tanta = 0
    case Ramadan_the_10th_City
    case The_6_of_October
    case Al_Arish
    case Al_Mahala
    case Al_Mansoura
    case Alexandria
    case Assuit
    case Aswan
    case bani_Swif
    case banha
    case Cairo
    
    case Damanhour
    case Dumiat
    case El_Wadi_El_Gadid
    case Fayoum
    case Giza
    case Helwan
    case Hurghada
    case Isamailia
    case kafr_aL_Sheikh
    case Luxor
    case Marsa_Matrouh
    case Minia
    case New_salhia
    case minia
    case New_Salhia
    case Port_Said
    case Qena
    case Sadat_City
    case Sharm_City
    case Shebin_El_Koum
    case Sohag_City
    case Suez
    case Zakazik
    
    func stringValue() -> String {
        switch self {
        case  .Tanta:  return  isAr() ? "طنطا": "Tanta"
        case .Ramadan_the_10th_City:  return   isAr() ? "العاشر من رمضان": "the 10th of Ramadan"
        case .The_6_of_October:  return   isAr() ? "السادس من إكتوبر": "October the 6th"
        case .Al_Mahala:  return   isAr() ? "المحلة الكبرى": "Al Mahala"
        case .Al_Arish:  return   isAr() ? "العريش": "Al Alrish"
        case .Al_Mansoura:   return  isAr() ? "المنصورة": "Al Mansoura"
        case .Alexandria:  return   isAr() ? "الإسكندرية": "Alex"
            //         default:  return ""
            
        case .Assuit:
            return   isAr() ? "أسيوط": "Assuit"
        case .Aswan:
            return   isAr() ? "أسوان": "Aswan"
        case .bani_Swif:
            return   isAr() ? "بنى سويف": "Bani_Swif"
        case .banha:
            return   isAr() ? "بنها": "Banha"
        case .Cairo:
            return   isAr() ? "القاهرة": "Cairo"
            
            
        case .Damanhour:
            return   isAr() ? "دمنهور": "Damanhour"
        case .Dumiat:
            return   isAr() ? "دمياط": "Dumiat"
        case .El_Wadi_El_Gadid:
            return   isAr() ? "الوادي الجديد": "El_Wadi_El_Gadid"
        case .Fayoum:
            return   isAr() ? "الفيوم": "Fayoum"
        case .Giza:
            return   isAr() ? "الجيزة": "Giza"
        case .Helwan:
            return   isAr() ? "حلوان": "Helwan"
        case .Hurghada:
            return   isAr() ? "الغردقة": "Hurghada"
        case .Isamailia:
            return   isAr() ? "الإسماعيلية": "Isamailia"
        case .kafr_aL_Sheikh:
            return   isAr() ? "كفر الشيخ": "kafr_aL_Sheikh"
        case .Luxor:
            return   isAr() ? "الأقصر": "Luxor"
        case .Marsa_Matrouh:
            return   isAr() ? "مرسي مطروح": "Marsa_Matrouh"
        case .Minia:
            return   isAr() ? "المنيا": "Minia"
        case .New_salhia:
            return   isAr() ? "الصالحية الجديدة": "New_salhia"
        case .minia:
            return   isAr() ? "المنيا": "minia"
        case .New_Salhia:
            return   isAr() ? "الصالحية الجديدة": "New_Salhia"
        case .Port_Said:
            return   isAr() ? "بورسعيد": "Port_Said"
        case .Qena:
            return   isAr() ? "قنا": "Qena"
        case .Sadat_City:
            return   isAr() ? "مدينة السادات": "Sadat_City"
        case .Sharm_City:
            return   isAr() ? "شرم الشيخ": "Sharm_City"
        case .Shebin_El_Koum:
            return   isAr() ? "شبين الكوم": "Shebin_El_Koum"
        case .Sohag_City:
            return   isAr() ? "سوهاج": "Sohag_City"
        case .Suez:
            return   isAr() ? "السويوس": "Suez"
        case .Zakazik:
            return   isAr() ? "الزقازيق": "Zakazik"
        }
    }
    func getDistricts() -> [District] {
        switch self {
            
            
        case .Alexandria: return getDis(start: 0, endIndex: 29)
        case .Cairo: return getDis(start: 30, endIndex: 68)
        case .Giza: return getDis(start: 70, endIndex: 79)
            
        //            [District.Agami,District.Abou_Kir]
        default:  return []
            
        }
    }
    fileprivate func getDis(start: Int ,endIndex : Int ) -> [District]{
        var data : [District] = []
        for x in start...endIndex {
            data.append(District.init(rawValue: x)!)
        }
        return data
    }}

enum District  : Int  {
    private func isAr() -> Bool {
        return   L102Language.currentAppleLanguage() == "ar"
    }
    //Alex
    case Abou_Kir = 0
    case Agami
    case Asafra
    case Azarita
    case Bahary
    case Bolkly
    case Borg_Arab
    case Cleopatra
    case El_Montaza
    case Fleming
    case Gleem
    case Ibrahimya
    case Iauran
    case Maamoura
    case Mandara
    case Manshia // 16
    case Miami
    case Moharam_Brk
    case Moustafa_kamel
    case raml_station
    case Roushddy
    case san_Estefano
    case Shatby
    case Sidi_Bishr
    case Sidi_Gaber
    case Smouha
    case Sporting
    case Victoria
    case Zezenia //29
    
    
    
    //Cairo
    case May_15th_City // 30
    case Abbasiyya
    case Abou_Rawash
    case Ain_Shams
    case Amiria
    case Azhar
    case Basateen
    case Boulak_El_Dakroor
    case El_Kal3a
    case Daher
    case Down_Town
    case El_Rehab
    case El_Tahrir
    case Garden_City
    case Ghamra
    case Hadaiq_Al_Qubba
    case Heliopolis
    case helmeya
    case Kasr_El_Eini
    case Kattamia
    case Maadi
    case  Manyal
    case Masaken_Sheraton
    case Matareya
    case Misr_El_Kadima
    case Mokattam
    case naser_City
    case New_Maadi
    case New_Nozha
    case Obour_City
    case Others
    case Ramsis
    case Sayeda_Naffisa
    case Sayeda_Zeinab
    case Saharabeya
    case Shoubra
    case Shoubra_El_Khema
    case Tagm3_Khames
    case Zamalek
    
    
    
    
    
    
    
    
    
    case Zaytoon //69
    //Giza
    case Agouza
    case Dokkia
    case Faissal
    case Giza_and_Pyramids
    case Harania
    case imbaba
    case Kitkat
    case Mansoureya
    case Mohandessin
    case Saft_El_Laba//79
    
    func stringValue() -> String {
        switch self {
        case .Abou_Kir:
            return  isAr() ? "أبو قير": "Abou_Kir"
        case .Agami :
            return  isAr() ? "العجمى": "Agami"
            
        case .Asafra:
            return  isAr() ? "العصفرة": "Asafra"
            
        case .Azarita:
            return  isAr() ? "الأزاريطة": "Azarita"
            
        case .Bahary:
            return  isAr() ? "بحري": "Bahary"
            
        case .Bolkly:
            return  isAr() ? "Bolkly": "Bolkly"
            
        case .Borg_Arab:
            return  isAr() ? "برج العرب": "Borg_Arab"
            
        case .Cleopatra:
            return  isAr() ? "كيلوبترا": "Cleopatra"
            
        case .El_Montaza:
            return  isAr() ? "المنتزة": "El_Montaza"
            
        case .Fleming:
            return  isAr() ? "الفلامنج": "Fleming"
            
        case .Gleem:
            return  isAr() ? "جليم": "Gleem"
            
        case .Ibrahimya:
            return  isAr() ? "الإبراهيمية": "Ibrahimya"
            
        case .Iauran:
            return  isAr() ? "Iauran": "Iauran"
            
        case .Maamoura:
            return  isAr() ? "المعمورة": "Maamoura"
            
        case .Mandara:
            return  isAr() ? "المندرة": "Mandara"
            
        case .Manshia:
            return  isAr() ? "المنشية": "Manshia"
            
        case .Miami:
            return  isAr() ? "ميامى": "Miami"
            
        case .Moharam_Brk:
            return  isAr() ? "محرم بك": "Moharam_Bek"
            
        case .Moustafa_kamel:
            return  isAr() ? "مصطفي كامل": "Moustafa_kamel"
            
        case .raml_station:
            return  isAr() ? "محطة الرمل": "Raml_station"
            
        case .Roushddy:
            return  isAr() ? "رشدي": "Roushddy"
            
        case .san_Estefano:
            return  isAr() ? "سان إستفنو": "San_Estefano"
            
        case .Shatby:
            return  isAr() ? "الشاطبى": "Shatby"
            
        case .Sidi_Bishr:
            return  isAr() ? "سيدي بشر": "Sidi_Bishr"
            
        case .Sidi_Gaber:
            return  isAr() ? "سيدي جابر": "Sidi_Gaber"
            
        case .Smouha:
            return  isAr() ? "سموحة": "Smouha"
            
        case .Sporting:
            return  isAr() ? "سبورتنج": "Sporting"
            
        case .Victoria:
            return  isAr() ? "فيكتوريا": "Victoria"
            
        case .Zezenia:
            return  isAr() ? "زيزينيا": "Zezenia"
            
        case .May_15th_City:
            return  isAr() ? "الخامس عشر من مايو": "May_15th_City"
        case .Abbasiyya:
            return  isAr() ? "العباسية": "Abbasiyya"
        case .Abou_Rawash:
            return  isAr() ? "أبو رواش": "Abou_Rawash"
        case .Ain_Shams:
            return  isAr() ? "عين شمس": "Ain_Shams"
        case .Amiria:
            return  isAr() ? "الأميرية": "Amiria"
        case .Azhar:
            return  isAr() ? "الأزهر": "Azhar"
        case .Basateen:
            return  isAr() ? "البساتين": "Basateen"
        case .Boulak_El_Dakroor:
            return  isAr() ? "بولاق الدكرور": "Boulak_El_Dakroor"
        case .El_Kal3a:
            return  isAr() ? "القلعة": "El_Kal3a"
        case .Daher:
            return  isAr() ? "Daher": "Daher"
        case .Down_Town:
            return  isAr() ? "وسط البلد": "Down Town"
        case .El_Rehab:
            return  isAr() ? "الرحاب": "El_Rehab"
        case .El_Tahrir:
            return  isAr() ? "التحرير": "El_Tahrir"
        case .Garden_City:
            return  isAr() ? "جاردن سيتي": "Garden_City"
        case .Ghamra:
            return  isAr() ? "غمره": "Ghamra"
        case .Hadaiq_Al_Qubba:
            return  isAr() ? "حدائق القبة": "Hadaiq_Al_Qubba"
        case .Heliopolis:
            return  isAr() ? "هيليوبلس": "Heliopolis"
        case .helmeya:
            return  isAr() ? "حلمية الزيتون": "helmeya"
        case .Kasr_El_Eini:
            return  isAr() ? "القصر العيني": "Kasr_El_Eini"
        case .Kattamia:
            return  isAr() ? "القطامية": "Kattamia"
        case .Maadi:
            return  isAr() ? "المعادى": "Maadi"
        case .Manyal:
            return  isAr() ? "المنيل": "Manyal"
        case .Masaken_Sheraton:
            return  isAr() ? "مساكن الشيرتون": "Masaken_Sheraton"
        case .Matareya:
            return  isAr() ? "المطرية": "Matareya"
        case .Misr_El_Kadima:
            return  isAr() ? "مصر القديمة": "Misr_El_Kadima"
        case .Mokattam:
            return  isAr() ? "المقطم": "Mokattam"
        case .naser_City:
            return  isAr() ? "مدينة ناصر": "naser_City"
        case .New_Maadi:
            return  isAr() ? "المعادي الجديدة": "New_Maadi"
        case .New_Nozha:
            return  isAr() ? "النزههة الجديدة": "New_Nozha"
        case .Obour_City:
            return  isAr() ? "العبور": "Obour_City"
        case .Others:
            return  isAr() ? "أخرى": "Others"
        case .Ramsis:
            return  isAr() ? "رمسيس": "Ramsis"
        case .Sayeda_Naffisa:
            return  isAr() ? "السيدة نفيسه": "Asayeda_Naffisabou_Kir"
        case .Sayeda_Zeinab:
            return  isAr() ? "السيدة زينب": "Sayeda_Zeinab"
        case .Saharabeya:
            return  isAr() ? "الشرشبية": "Saharabeya"
        case .Shoubra:
            return  isAr() ? "شبرة": "Shoubra"
        case .Shoubra_El_Khema:
            return  isAr() ? "سوق الخميس": "Shoubra_El_Khema"
        case .Tagm3_Khames:
            return  isAr() ? "التجمع الخامس": "Tagm3_Khames"
        case .Zamalek:
            return  isAr() ? "الزمالك": "Zamalek"
        case .Zaytoon:
            return  isAr() ? "الزيتون": "Zaytoon"
        case .Agouza:
            return  isAr() ? "العجوزة": "Agouza"
        case .Dokkia:
            return  isAr() ? "الدقى": "Dokkia"
        case .Faissal:
            return  isAr() ? "فيصل": "Faissal"
        case .Giza_and_Pyramids:
            return  isAr() ? "الجيزة والأهرامات": "Giza_and_Pyramids"
        case .Harania:
            return  isAr() ? "Harania": "Harania"
        case .imbaba:
            return  isAr() ? "إمبابة": "imbaba"
        case .Kitkat:
            return  isAr() ? "الكيت كات": "Kitkat"
        case .Mansoureya:
            return  isAr() ? "المنصورية": "Mansoureya"
        case .Mohandessin:
            return  isAr() ? "المهندسيين": "Mohandessin"
        case .Saft_El_Laba:
            return  isAr() ? "صفت اللبن": "Saft_El_Laba"
        }
    }
    
}
