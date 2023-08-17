//
//  ProductsView.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 03.08.23.
//

import SwiftUI

struct ProductsView: View {
    
    @StateObject private var viewModel = ProductsViewModel()
    
    var body: some View {
            List {
                ForEach(viewModel.products) { product in
                    ProductCellView(product: product)
                        .contextMenu {
                            Button("Add to Favorite") {
                                viewModel.addUserFavoriteProduct(productId: product.id)
                            }
                        }
                    if product == viewModel.products.last {
                        ProgressView()
                            .onAppear {
                                viewModel.getProducts()
                            }
                    }
                
            }
        }
        .navigationTitle("Products")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Menu("Filter: \(viewModel.selectedFilter?.rawValue ?? "None")") {
                    ForEach(ProductsViewModel.FilterOption.allCases, id:\.self) { option in
                        Button(option.rawValue) {
                            Task {
                                try? await viewModel.filterOption(option: option)
                            }
                        }
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("Sorting: \(viewModel.selectedCategory?.rawValue ?? "None")") {
                    ForEach(ProductsViewModel.CategoryOption.allCases, id:\.self) { option in
                        Button(option.rawValue) {
                            Task {
                                try? await viewModel.categoryOption(option:option)
                            }
                        }
                    }
                }
            }
        })
        .onAppear {
            viewModel.getProducts()
            viewModel.getProductsCount()
        }
            
    }
        
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductsView()
        }
    }
}
