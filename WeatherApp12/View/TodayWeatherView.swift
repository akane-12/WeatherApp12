//
//  TodayWeatherView.swift
//  WeatherApp12
//
//  Created by cmStudent on 2022/07/09.
//

import SwiftUI

struct TodayWeatherView: View {
    
    struct Input {
        
        //let id: UUID = UUID()
        
        let description: String
        let icon: UIImage
        
        let temp: String
        let humidity: String
        
        let name: String
    }
    
    let input: Input
    
    var body: some View {
        
        ZStack {
            
            HStack {
                iconImage
                Spacer()
            }
            
            VStack {
                
                HStack(alignment: .bottom) {
                    cityName
                    Spacer()
                    descriptionText
                }
                .padding(.top, 10)
                
                
                Spacer()
                
                HStack {
                    Spacer()
                    Image(systemName: "thermometer")
                        .foregroundColor(.white)
                    tempText
                    Text("/")
                        .font(.title2)
                        .foregroundColor(.white)
                    feelsLikeText
                }
                .padding(.bottom, 10)
            }
            
        }
        .frame(maxWidth: 350,
               maxHeight: 150)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.white, lineWidth: 1))
        
        
    }
    
    var cityName: some View {
        Text("\(input.name)")
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding(.leading, 20)
        
    }
    
    var descriptionText: some View {
        Text("\(input.description)")
            .font(.title)
            .foregroundColor(.white)
            .fontWeight(.light)
            .padding(.trailing, 20)
        
    }
    
    var tempText: some View {
        Text("\(input.temp)℃")
            .font(.title2)
            .foregroundColor(.white)
    }
    
    var feelsLikeText: some View {
        Text("\(input.humidity)％")
            .font(.title2)
            .foregroundColor(.white)
            .padding(.trailing, 10)
    }
    
    var iconImage: some View {
        Image(uiImage: input.icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200)
            .opacity(0.5)
            .padding([.leading, .top], 10)
    }
    
}

struct TodayWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWeatherView(input: TodayWeatherView.Input(description: "曇りがち",
                                                       icon: UIImage(named: "job_otenki_oneesan")!,
                                                       temp: "30.55",
                                                       humidity: "30",
                                                       name: "東京都"))
    }
}
