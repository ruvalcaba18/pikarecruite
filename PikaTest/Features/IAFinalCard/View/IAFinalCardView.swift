//  IAFinalCardView.swift
//  PikaTest
//  Created by jael ruvalcaba on 24/04/26.
import SwiftUI

struct IAFinalCardView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var coordinator: AppCoordinator
    
    public init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    private enum Constants {
        static let mainTitle = "MEET SEMI"
        static let subTitle = "Your AI Self is ready to chat"
        static let openMessages = "Open Messages"
        static let shareId = "Share ID Card"
        static let cardName = "SEMI"
        
        static let bornLabel = "BORN ON PIKA"
        static let bornDate = "FEB 11, 2026"
        static let locationLabel = "LOCATION"
        static let locationValue = "SAN FRANCISCO, CA"
        static let statusLabel = "STATUS"
        static let statusValue = "ALIVE"
        static let findLabel = "FIND ME ON"
        static let findValue = "PIKA.ME/LUNA-SMITH"
        
        static let cardRotation: Double = -2.0
        static let avatarCornerRadius: CGFloat = 16.0
        static let barcodeHeight: CGFloat = 140.0
        static let barcodeWidth: CGFloat = 40.0
    }
    
    var body: some View {
        ZStack {
            backgroundLayer
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppConstants.Spacing.stackSpacingStandard) {
                    headerArea
                    
                    Spacer(minLength: 20)
                    
                    idCardElement
                        .rotationEffect(.degrees(Constants.cardRotation))
                        .padding(.horizontal, 20)
                    
                    Spacer(minLength: 40)
                    
                    footerInfo
                    
                    actionButtons
                }
                .padding(.horizontal, AppConstants.Spacing.screenHorizontalPadding)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

private extension IAFinalCardView {
    
    var backgroundLayer: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color.white, Color(red: 0.98, green: 0.97, blue: 0.94)]),
            center: .center,
            startRadius: 2,
            endRadius: 500
        )
        .ignoresSafeArea()
    }
    
    var headerArea: some View {
        HStack {
            Spacer()
            Button(action: { coordinator.popToMain() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
                    .padding(12)
                    .background(Circle().fill(.white).shadow(radius: 2))
            }
        }
        .padding(.top, 10)
    }
    
    var idCardElement: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.0, green: 0.6, blue: 1.0))
                .offset(y: 4)
            

            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top) {
                    Image("IA_AVATAR")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 180)
                        .cornerRadius(Constants.avatarCornerRadius)
                    
                    Spacer()
                    
                    Image("rabbit")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.black)
                        .frame(width: 40, height: 35)
                }
                .padding([.top, .horizontal], 20)
                
                Text(Constants.cardName)
                    .font(.telkaExtendedBlack(size: 32))
                    .padding(.top, 15)
                    .padding(.horizontal, 22)
                
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 3)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 15)
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 12) {
                        cardDetailRow(label: Constants.bornLabel, value: Constants.bornDate)
                        cardDetailRow(label: Constants.locationLabel, value: Constants.locationValue)
                        cardDetailRow(label: Constants.statusLabel, value: Constants.statusValue)
                        cardDetailRow(label: Constants.findLabel, value: Constants.findValue)
                    }
                    
                    Spacer()
                    
                    Image("scan_bar")
                        .resizable()
                        .frame(width: Constants.barcodeWidth, height: Constants.barcodeHeight)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.97))
            .cornerRadius(12)
            .padding(1) 
        }
    }
    
    func cardDetailRow(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.telkaExtendedBlack(size: 10))
                .foregroundColor(.black)
            Text(value)
                .font(.telkaRegular(size: 13))
                .foregroundColor(.black.opacity(0.8))
        }
    }
    
    var footerInfo: some View {
        VStack(spacing: 8) {
            Text(Constants.mainTitle)
                .font(.telkaExtendedBlack(size: 38))
                .foregroundColor(.black)
            
            Text(Constants.subTitle)
                .font(.telkaRegular(size: 18))
                .foregroundColor(.black)
        }
    }
    
    var actionButtons: some View {
        VStack(spacing: 12) {
            Button(action: {}) {
                HStack {
                    Text(Constants.openMessages)
                    Image(systemName: "arrow.up.right")
                }
                .font(.telkaMedium(size: 16))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: AppConstants.Layout.buttonHeight)
                .background(Color.black)
                .cornerRadius(AppConstants.Layout.standardCornerRadius)
            }
            
            Button(action: {}) {
                HStack {
                    Text(Constants.shareId)
                    Image(systemName: "square.and.arrow.up")
                }
                .font(.telkaMedium(size: 16))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: AppConstants.Layout.buttonHeight)
                .background(Color(red: 0.95, green: 0.93, blue: 0.9))
                .cornerRadius(AppConstants.Layout.standardCornerRadius)
            }
        }
        .padding(.bottom, 30)
    }
}

#if targetEnvironment(simulator)
#Preview {
    IAFinalCardView()
}
#endif
