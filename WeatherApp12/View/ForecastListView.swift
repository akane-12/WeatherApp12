//
//  ForecastListView.swift
//  WeatherApp12
//
//  Created by cmStudent on 2022/07/10.
//

import SwiftUI

struct ForecastListView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @Binding var isShowListView: Bool
    
    struct Input {
        let name: String
        let lists: [List]
        
        struct List: Identifiable {
            
            let id: UUID = UUID()
            let temp: String
            let humidity: String
            let description: String
            let icon: UIImage
            let year: String
            let month: String
            let day: String
            let time: String
        }
    }
    //let input: Input

    
    var body: some View {
        ZStack {
            Color(red: 33/255, green: 33/255, blue: 33/255)
            
            VStack {
                HStack {
                    Button {
                        isShowListView = false
                    } label: {
                        Image(systemName: "arrowshape.turn.up.backward.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 35)
                            .padding(.top, 40)
                            .padding(.leading, 20)
                    }
                    
                    Spacer()
                }
                
                topTitle
                
                ScrollView {
                    VStack {
                        listView
                        Spacer()
                    }
                }
            }
            
        }
        .ignoresSafeArea(.all)
    }
    
    var topTitle: some View {
        VStack {
            Text("＊ \(viewModel.forecastListInput.lists[0].month)/\(viewModel.forecastListInput.lists[0].day)　\(viewModel.forecastListInput.name) ＊")
                .font(.largeTitle)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.top, 30)
                .padding(.leading, 10)
            
        }
    }
    
    var listView: some View {
        ForEach(viewModel.forecastListInput.lists) { list in
            ZStack {
                HStack {
                    Image(uiImage: list.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .opacity(0.5)
                        .padding(.leading, 30)
                        .padding(10)
                    
                    Spacer()
                }
                
                VStack {
                    HStack(alignment: .bottom) {
                        Text("\(list.time)")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.leading, 20)
                        
                        Spacer()
                        
                        Text("\(list.description)")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Image(systemName: "thermometer")
                            .foregroundColor(.white)
                        Text("\(list.temp)℃ / \(list.humidity)％")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.trailing, 10)
                    }
                }
                .padding(10)
            }
            .frame(maxWidth: 350,
                   maxHeight: 120)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 1))
        }
        
    }
    
    
}

//struct ForecastListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastListView(
//            isShowListView: $true, input: ForecastListView.Input(
//                name: "東京都ああ",
//                lists: [ForecastListView.Input.List(
//                    temp: "11.11",
//                    humidity: "11",
//                    description: "１１１１",
//                    icon: UIImage(named: "now_download")!,
//                    year: "1111",
//                    month: "11",
//                    date: "11",
//                    time: "11:11"),
//                        ForecastListView.Input.List(
//                            temp: "22.22",
//                            humidity: "22",
//                            description: "２２２２",
//                            icon: UIImage(named: "now_download")!,
//                            year: "2222",
//                            month: "22",
//                            date: "22",
//                            time: "22:22")]))
//    }
//}
