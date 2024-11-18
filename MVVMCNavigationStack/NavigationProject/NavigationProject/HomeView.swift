import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
            VStack {
                Button("Go to User Profile") {
                    viewModel.navigateToUser()
                }
                Button("Go to Order Details") {
                    viewModel.navigateToOrder()
                }
            }
    }
}
