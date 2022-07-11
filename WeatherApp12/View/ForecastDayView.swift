//
//  ForecastDayView.swift
//  WeatherApp12
//
//  Created by cmStudent on 2022/07/09.
//

import SwiftUI

struct ForecastDayView: View {
    
    struct Input: Identifiable {
        let id: UUID = UUID()
        
        let month: String
        let day: String
        let icon: UIImage
        
        let allItem: ForecastListView.Input
    }
    
    let input: Input
    
    var body: some View {
        ZStack {
            
            //Color(red: 33/255, green: 33/255, blue: 33/255)
            
            HStack {
                Spacer()
                iconImage
            }
            
            VStack {
                Spacer()
                HStack {
                    dateText
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(maxWidth: 350,
               maxHeight: 100)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.white, lineWidth: 1))
    }
    
    
    var dateText: some View {
        Text("\(input.month)/\(input.day)")
            .font(.largeTitle)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.leading, 20)
    }
    
    var iconImage: some View {
        Image(uiImage: input.icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 90)
            .opacity(0.5)
            .padding(.trailing, 20)
    }
}

struct ForecastWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDayView(input: ForecastDayView.Input(month: "xx", day: "xx", icon: UIImage(named: "now_download")!, allItem: ForecastListView.Input(name: "---", lists: [ForecastListView.Input.List(temp: "xx.xx", humidity: "xx", description: "----", icon: UIImage(named: "now_download")!, year: "xx", month: "xx", day: "xx", time: "xx:xx")])))
    }
}
