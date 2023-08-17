//
//  ProductCellView.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 03.08.23.
//

import SwiftUI

struct ProductCellView: View {
    
    let product: Product
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: product.thumbnail ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 75)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 75,height: 75)
            .shadow(radius: 10)
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title ?? "n/a")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("Price: $ " + String(product.price ?? 0) )
                Text("Rating: " + String(product.rating ?? 0))
                Text("Category: " + (product.category ?? "n/a"))
                Text("Brand: " + (product.brand ?? "n/a"))
                
            }
            .font(.callout)
            .foregroundColor(.secondary)

        }
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(product: Product(id: 1, title: "Test Title", description: "Test Desctiption", price: 123, discountPercentage: 12, rating: 12, stock: 2, brand: "Prada", category: "purses", thumbnail: "test.com", images: nil))
    }
}
