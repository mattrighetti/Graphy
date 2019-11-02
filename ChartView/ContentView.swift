//
//  ContentView.swift
//  ChartView
//
//  Created by Mattia Righetti on 01/11/2019.
//  Copyright © 2019 Mattia Righetti. All rights reserved.
//

import SwiftUI

struct ColorRGB {
    var red: Double
    var green: Double
    var blue: Double
}

struct ContentView: View {
    
    @State private var dataPicker: String = "Data1"
    
    private var dataBackgroundColor: [ String : ColorRGB ] = [
        "Data1" : ColorRGB(red: 44/255, green: 54/255, blue: 79/255),
        "Data2" : ColorRGB(red: 76/255, green: 61/255, blue: 89/255),
        "Data3" : ColorRGB(red: 56/255, green: 24/255, blue: 47/255)
    ]
    
    private var dataBarColor: [ String : ColorRGB ] = [
        "Data1" : ColorRGB(red: 222/255, green: 44/255, blue: 41/255),
        "Data2" : ColorRGB(red: 42/255, green: 74/255, blue: 150/255),
        "Data3" : ColorRGB(red: 47/255, green: 57/255, blue: 77/255)
    ]
    
    private var data: [ String : [Int] ] = [
        "Data1" : [28, 25, 30, 29, 23],
        "Data2" : [3, 1, 2, 4, 3],
        "Data3" : [2, 6, 8, 3, 4]
    ]
    
    var body: some View {
        
        ZStack {
            
            Color(.sRGB,
                  red: self.dataBackgroundColor[dataPicker]!.red,
                  green: self.dataBackgroundColor[dataPicker]!.green,
                  blue: self.dataBackgroundColor[dataPicker]!.blue
            )
                .edgesIgnoringSafeArea(.all)
                .animation(.default)
            
            VStack {
                
                Text("Let's Graph!")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Picker("", selection: $dataPicker) {
                    Text("Data1").tag("Data1")
                    Text("Data2").tag("Data2")
                    Text("Data3").tag("Data3")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                CapsuleGraphView(data: data[dataPicker]!, maxValueInData: data[dataPicker]!.max()!, spacing: 24, capsuleColor: dataBarColor[dataPicker]!)
                
            }
        }
    }
    
}

struct CapsuleGraphView: View {
    
    var data: [Int]
    var maxValueInData: Int
    var spacing: CGFloat
    var capsuleColor: ColorRGB
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                CapsuleBar(value: self.data[0], maxValue: self.maxValueInData, width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count), valueName: "val1", capsuleColor: self.capsuleColor)
                CapsuleBar(value: self.data[1], maxValue: self.maxValueInData, width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count), valueName: "val2", capsuleColor: self.capsuleColor)
                CapsuleBar(value: self.data[2], maxValue: self.maxValueInData, width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count), valueName: "val3", capsuleColor: self.capsuleColor)
                CapsuleBar(value: self.data[3], maxValue: self.maxValueInData, width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count), valueName: "val4", capsuleColor: self.capsuleColor)
                CapsuleBar(value: self.data[4], maxValue: self.maxValueInData, width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count), valueName: "val5", capsuleColor: self.capsuleColor)
            }
        }.frame(height: 500)
    }
    
}

struct CapsuleBar: View {
    
    var value: Int
    var maxValue: Int
    var width: CGFloat
    var valueName: String
    var capsuleColor: ColorRGB
    
    var body: some View {
        VStack {
            
            Text("\(value)")
            
            ZStack(alignment: .bottom) {
                
                Capsule()
                    .fill(Color.gray)
                    .opacity(0.1)
                    .frame(width: width, height: 400)
                
                Capsule()
                    .fill(
                        Color(.sRGB, red: capsuleColor.red, green: capsuleColor.green, blue: capsuleColor.blue)
                    )
                    .frame(width: width, height: CGFloat(value) / CGFloat(maxValue) * 400)
                    .animation(.easeOut(duration: 0.5))
                
            }
            
            Text("\(valueName)")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
