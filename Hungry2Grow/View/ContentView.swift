//
//  ContentView.swift
//  Hungry2Grow
//
//  Created by Vedant Patil on 12/04/24.
//

import SwiftUI

struct ContentView: View {
    //MARK:- PROPERTIES
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = ItemViewModel()
    @State var showContentView: Bool = false
    @State private var isDarkMode = false
    let screenWidth = UIScreen.main.bounds.width
    
    //MARK:- VIEW
    var body: some View {
        
        //Mark:-Navigation View
        NavigationView{
            
            //Mark:- Main VStack
            VStack {
                //Mark:- Loading screen
                if viewModel.items.isEmpty && viewModel.errorMessage == nil {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color.gray.opacity(0.75))
                        .overlay(
                            HStack {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                Text("Loading...")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.leading, 3)
                            }
                            .padding()
                            .font(.system(size: 18))
                            .multilineTextAlignment(.center)
                        )
                        .frame(width: 140, height: 80)
                                    
                }
                //Mark:- Network connection error
                else if let errorMessage = viewModel.errorMessage {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color.gray.opacity(0.75))
                        .overlay(
                            Text(errorMessage)
                                .font(.system(size: 18))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        )
                        .frame(width: 250, height: 130)
                        .lineLimit(3)
                } else {
                    //Mark:- ScrollView
                    ScrollView(.vertical){
                        //Mark:-loop
                        ForEach(viewModel.items, id: \.id) { item in
                            //Mark:- Navigation Link
                            NavigationLink(destination: ItemDetailView(item: item)) {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(item.title)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .lineLimit(3)
                                        .foregroundColor(colorScheme == .dark ? .white : .primary)
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(item.body)
                                        .font(.footnote)
                                        .foregroundColor(colorScheme == .dark ? .gray : .secondary)
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .frame(width: 320)
                                .padding()
                                .background(isDarkMode ? Color.gray.opacity(0.25) : Color.white)
                                .cornerRadius(15)
                                .offset(y: showContentView ? 0 : 75)
                                .opacity(showContentView ? 1 : 0)
                                .animation(.easeInOut(duration: 0.75))
                                .shadow(radius: 1)
                            }//:NavigationLink
                            .padding(.horizontal, 20)
                        }//:loop
                        .padding(.top, 20)
                    }//:ScrollView
                    .background(Color.gray.opacity(0.20))
                    .cornerRadius(20)
                }//:else
            }//:main VStack
            .onAppear {
                viewModel.fetchItems()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showContentView = true
                }
            }
            .onDisappear {
                showContentView = false
            }
            .navigationTitle(viewModel.errorMessage == nil ? "Items" : "" )
            .navigationBarItems(trailing:
                Button(action: {
                
                        withAnimation(.easeOut(duration: 0.5)) {
                            isDarkMode.toggle()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeOut(duration: 0.5)) {
                                UIApplication.shared.windows.first?.rootViewController?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
                            }
                        }
                
                }) {
                        Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                        .imageScale(.large)
                        .foregroundColor(isDarkMode ?  .white : .black)
                   }
                        )
            
        }//:Navigtaion View
        .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview {
    ContentView()
}
