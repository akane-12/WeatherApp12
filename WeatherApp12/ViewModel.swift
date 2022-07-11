//
//  ViewModel.swift
//  WeatherApp12
//
//  Created by cmStudent on 2022/07/08.
//

import SwiftUI
import Combine

final class ViewModel: ObservableObject {
    
    // Viewの表示用
    @Published private(set) var todayInput: TodayWeatherView.Input = TodayWeatherView.Input(description: "-----",
                                                                                            icon: UIImage(named: "job_otenki_oneesan")!,
                                                                                            temp: "xx.xx",
                                                                                            humidity: "xx",
                                                                                            name: "---")
    
    @Published private(set) var forecastDayInput: [ForecastDayView.Input] =
    [ForecastDayView.Input(month: "xx", day: "xx", icon: UIImage(named: "now_download")!, allItem: ForecastListView.Input(name: "---", lists: [ForecastListView.Input.List(temp: "xx.xx", humidity: "xx", description: "----", icon: UIImage(named: "now_download")!, year: "xx", month: "xx", day: "xx", time: "xx:xx")]))]
    
    
    @Published var forecastListInput: ForecastListView.Input = ForecastListView.Input(name: "", lists: [ForecastListView.Input.List(temp: "", humidity: "", description: "", icon:  UIImage(named: "now_download")!, year: "", month: "", day: "", time: "")])
    
    // 都市名
    //@Published var inputCity: String = "Tokyo"
    @Published var selectCityIndex: Int = 0
    let citys = ["Tokyo", "Saitama", "Gunma", "Tochigi", "Ibaraki", "Chiba", "Kanagawa"]
    
    // エラーアラート
    @Published var isShowErrar = false
    
    
    
    
    private let makeSession: MakeSessionType
    
    private let todaySubject = PassthroughSubject<String, Never>()
    private let forecastSubject = PassthroughSubject<String, Never>()
    
    private let errorSubject = PassthroughSubject<APIError, Never>()
    
    private var cancellable = Set<AnyCancellable>()
    
    
    init(makeSessionType: MakeSessionType) {
        self.makeSession = makeSessionType
        bind()
    }
    
    
    private func bind() {
        
        todaySubject
            .flatMap{ city in
                self.makeSession.request(request: MakeRequestToday(city: city))
            }
            .catch { error -> Empty<TodayItem, Never> in
                self.errorSubject.send(error)
                return Empty()
            }
            .sink{ todayItem in
                self.todayInput = self.convertTodayInput(todayItem: todayItem)
            }.store(in: &cancellable)
        
        
        forecastSubject
            .flatMap{ city in
                self.makeSession.request(request: MakeRequestForcast(city: city))
            }
            .catch { error -> Empty<ForecastItem, Never> in
                self.errorSubject.send(error)
                return Empty()
            }
            .sink{ forecastItem in
                self.forecastDayInput = self.convertForecastInput(forecastItem: forecastItem)
            }.store(in: &cancellable)
        
        
        errorSubject
            .sink { error in
                self.isShowErrar = true
                print("E: viewModel/1 \(error) : \(error.localizedDescription)")
            }.store(in: &cancellable)
        
        print("C: bind")
        
    }
    
    private func convertTodayInput(todayItem: TodayItem) -> TodayWeatherView.Input {
        
        var input: TodayWeatherView.Input
        
        // アイコン画像
        let iconURL = URL(string: "http://openweathermap.org/img/wn/" + todayItem.weather[0].icon + "@2x.png")
        print("icon: \(todayItem.weather[0].icon)")
        let iconImage: UIImage?
        do {
            let data = try Data(contentsOf: iconURL!)
            iconImage = UIImage(data: data)
        } catch {
            print("iconError")
            iconImage = UIImage(named: "job_otenki_oneesan")
        }
        
        input = TodayWeatherView.Input(description: todayItem.weather[0].description,
                                       icon: iconImage!,
                                       temp: String(format: "%.2f", todayItem.main.temp),
                                       humidity: String(todayItem.main.humidity),
                                       name: todayItem.name)
        
        print("C: convertInput")
        
        return input
    }
    
    private func convertForecastInput(forecastItem: ForecastItem) -> [ForecastDayView.Input] {
        
        var input: [ForecastDayView.Input] = []
        
        var inputList: [ForecastListView.Input.List] = []
        
        
        // 時間の
        let dateFormatter = DateFormatter()
        //dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "JST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "HH:mm"
        
        let name = forecastItem.city.name
        
        let tmpTime = "21:00"
    
        for item in forecastItem.list {
            
            // 時間
            print("timeeee: \(item.dtTxt)")
            let dtTextUTC = item.dtTxt + " +0000"
            let date = dateFormatter.date(from: dtTextUTC)
            let year = Calendar.current.component(.year, from: date!)
            let month = Calendar.current.component(.month, from: date!)
            let day = Calendar.current.component(.day, from: date!)
            let time = dateFormatterInput.string(from: date!)
            
            // アイコン
            let iconURL = URL(string: "http://openweathermap.org/img/wn/" + item.weather[0].icon + "@2x.png")
            //print("icon: \(item.weather[0].icon)")
            let iconImage: UIImage?
            do {
                let data = try Data(contentsOf: iconURL!)
                iconImage = UIImage(data: data)
            } catch {
                print("iconError")
                iconImage = UIImage(named: "now_download")
            }
            
            
            inputList
                .append(ForecastListView.Input.List(temp: String(format: "%.2f",
                                                                 item.main.temp),
                                                    humidity: String(item.main.humidity),
                                                    description:item.weather[0].description,
                                                    icon: iconImage!,
                                                    year: String(year),
                                                    month: String(month),
                                                    day: String(day),
                                                    time: time))
            
            
            if time == tmpTime {
                
                input.append(ForecastDayView.Input(month: String(month),
                                                   day: String(day),
                                                   icon: iconImage!,
                                                   allItem: ForecastListView.Input(name: name,
                                                                                   lists: inputList)))
                print(inputList)
                inputList = []
                
            }
            
            
        }
        
        
        print("C: convertInput")
        
        return input
    }
    
    
    func apply() {
        
        todaySubject.send(citys[selectCityIndex])
        forecastSubject.send(citys[selectCityIndex])
        
        print("C: apply")
    }
}
