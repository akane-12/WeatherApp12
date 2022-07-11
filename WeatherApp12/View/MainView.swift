//
//  MainView.swift
//  WeatherApp12
//
//  Created by cmStudent on 2022/07/09.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = ViewModel(makeSessionType: MakeSessionToday())
    
    @State var isShowListView = false
    @State var isShowSetView = false
    
    
    var body: some View {
        
        ZStack {
            Color(red: 33/255, green: 33/255, blue: 33/255)
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        isShowSetView = true
                    } label: {
                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 35)
                            .padding(.top, 40)
                            .padding(.trailing, 20)
                    }
                    .fullScreenCover(isPresented: $isShowSetView) {
                            SetView(viewModel: viewModel, isShowSetView: $isShowSetView)
                    }
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("＊ Today ＊")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                            .padding(.leading, 10)
                        
                        TodayWeatherView(input: viewModel.todayInput)
                            .onAppear {
                                viewModel.apply()
                            }
                        
                        
                        Text("＊ Forecast ＊")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                            .padding(.leading, 10)
                        
                        
                        ForEach(viewModel.forecastDayInput) { input in
                            Button {
                                isShowListView = true
                                viewModel.forecastListInput = input.allItem
                                print(input.allItem)
                            } label: {
                                ForecastDayView(input: input)
                            }
                            .fullScreenCover(isPresented: $isShowListView) {
                                ForecastListView(
                                    viewModel: viewModel, isShowListView: $isShowListView)
                            }

                        }


                        
                        Spacer()
                    }
                }
                
            }
        }
        .ignoresSafeArea(.all)
        
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
