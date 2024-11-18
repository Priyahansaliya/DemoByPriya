//
//  PopUpView.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 16/07/24.
//

import SwiftUI


struct PopUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var strHeaderTitle: String = "Select State Service"
    @State var arrList: [DropDownModel]
    @State var selectedId = -1
    @State var selected: String = ""
    @State var selectedIndex: Int = 0
    var onSubmit: (Int) -> Void // Closure to pass selected value back to parent
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text(strHeaderTitle)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
                .background(Color.blue)
                
                if arrList.isEmpty {
                    Text("No records found")
                        .foregroundColor(.black)
                        .padding()
                } else {
                    Spacer().frame(height: 20)
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(arrList.indices, id: \.self) { index in
                            let list = arrList[index]
                            ListView(data: list, isSelected: list.id == "\(selectedId)")
                                .padding([.leading, .trailing], 16)
                                .onTapGesture {
                                    selected = list.id
                                    selectedId = Int(list.id) ?? 0
                                    selectedIndex = index
                                }
                            if index < arrList.count - 1 {
                                Divider()
                                    .background(Color.gray)
                                    .frame(height: 0.5)
                            }
                        }
                    }.frame(maxHeight: calculatePopupHeight())
                    Spacer().frame(height: 20)
                }
                
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Spacer()
                        Text("Cancel")
                            .font(Font.system(size: 16, weight: .regular))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .frame(height: 35)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    
                    Spacer()
                    Button(action: {
                        submitSelection()
                    }) {
                        Spacer()
                        Text("Submit")
                            .font(Font.system(size: 16, weight: .regular))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .frame(height: 35)
                    .background(Color.blue)
                    .cornerRadius(12)
                }
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            }
            .background(Color.white)
            .cornerRadius(12)
            .padding()
        }
        .background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
    }
    
    private func ListView(data: DropDownModel, isSelected: Bool) -> some View {
        HStack {
            Image(systemName: isSelected ? "star.fill" : "star")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
                .frame(width: 20, height: 20)
                .padding(.leading, 8)
            Text(data.title)
                .foregroundColor(.black)
                .font(.system(size: 16))
                .padding(.leading, 8)
            
            Spacer()
        }
        .frame(height: 44)
    }
    
    private func submitSelection() {
        let selectedValue = Int(arrList[selectedIndex].id)
        print("Selected value:", selectedValue as Any)
        onSubmit(selectedValue ?? 0) // Pass selected value to parent
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func calculatePopupHeight() -> CGFloat {
        let itemHeight: CGFloat = 44
        let maxHeight: CGFloat = CGFloat(arrList.count) * itemHeight + 35 + 32
        return min(maxHeight, UIScreen.main.bounds.height * 0.7)
    }
}

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = UIColor.clear.withAlphaComponent(0.7)
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}


struct CustomAppButton: View {
    
    @State var str: String
    @State var action: () -> ()
    @State var isNews: Bool = false
    
    var body: some View {
        Button(action: action) {
            Spacer()
            Text(str).font(Font( isNews ? UIFont.systemFont(ofSize: 14)  : UIFont.systemFont(ofSize: 16)))
                .foregroundColor(.white)
            Spacer()
        }
        .frame(height: 35)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.blue)
        .foregroundColor(.white)
        .border(Color.gray, width: 1)
        .cornerRadius(radius: 12, corners: .allCorners)
    }
}
