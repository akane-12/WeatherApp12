//
//  SetView.swift
//  WeatherApp12
//
//  Created by cmStudent on 2022/07/10.
//

import SwiftUI

struct SetView: View {
    //@Binding var isShowSetView: Bool
    
    @ObservedObject var viewModel: ViewModel
    
    //@State var selectCityIndex = 0

    
    //let citys = ["Tokyo", "Saitama"]
    
    @Binding var isShowSetView: Bool
    
    var body: some View {
        ZStack {
            Color(red: 33/255, green: 33/255, blue: 33/255)
            VStack {
                
                HStack {
                    Button {
                        isShowSetView = false
                        viewModel.apply()
                        print(viewModel.selectCityIndex)
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
                
                Spacer()
                
                Text("＊ Select City ＊")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
                
                Text("【 \(viewModel.citys[viewModel.selectCityIndex]) 】")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
                
                Picker("", selection: $viewModel.selectCityIndex) {
                    ForEach(0..<viewModel.citys.count, id: \.self) { i in
                        Text("\(viewModel.citys[i])").tag(i)
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                
                Spacer()
            }
        }
        .ignoresSafeArea(.all)
    }
}

//struct SetView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetView()
//    }
//}
