//
//  ItemDetailView.swift
//  Hungry2Grow
//
//  Created by Vedant Patil on 12/04/24.
//

import SwiftUI

struct ItemDetailView: View {
    //MARK:- PROPERTIES
    let item: Item
    @State private var showDetailView : Bool = false
    let screenWidth = UIScreen.main.bounds.width
    
    //MARK:- VIEW
    var body: some View {
        
        //Mark:- Main VStack
        VStack(alignment: .center, spacing: 10) {
                            Text(item.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
            
                           //Mark:-VStack for body
                            VStack(alignment: .leading,spacing: 7){
                                ForEach(item.body.components(separatedBy:"\n"), id: \.self) { line in
                                        Text(line)
                                            .font(.body)
                                }
                                .padding(.leading,20)
                            }//:VStack for body

                            Spacer()
                        }//:Main VStack
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showDetailView = true
                            }
                        }
                        .offset(y: showDetailView ? 0 : 75)
                        .opacity(showDetailView ? 1 : 0)
                        .animation(.easeInOut(duration: 0.5))
                        .navigationBarTitle("Item Detail", displayMode: .inline)
                        .navigationBarBackButtonHidden(true)
                                .navigationBarItems(leading: CustomBackButton())
                        .padding()
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .background(Color.gray.opacity(0.20))
                        
                        

    }
       
}

struct CustomBackButton: View {
    //MARK:- PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    //MARK:- VIEW
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Text("Back")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
        }
    }
}

#Preview {
    let sampleItem = Item(userId: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
    return ItemDetailView(item: sampleItem)
}
