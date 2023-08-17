//
//  ProductsDataBase.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 03.08.23.
//

import Foundation



import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Identifiable, Codable, Equatable {
    let id: Int
    let title: String?
    let description: String?
    let price: Int?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand, category: String?
    let thumbnail: String?
    let images: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case price
        case discountPercentage
        case rating
        case stock
        case brand
        case category
        case thumbnail
        case images
    }
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
}
//func downloadProductsAndUploadToFirebase() {
//    guard let url = URL(string: "https://dummyjson.com/products") else { return }
//
//    Task {
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let products = try JSONDecoder().decode(ProductArray.self, from: data)
//            let productArray = products.products
//
//            for product in productArray {
//                try? await ProductsManager.shared.uploadProduct(product: product)
//            }
//
//            print("SUCCESS")
//            print(products.products.count)
//        } catch {
//            print(error)
//        }
//    }
//}



final class ProductDatabase {
    
    static let products: [Product] = [
        Product(id: 1, title: Optional("iPhone 9"), description: Optional("An apple mobile which is nothing like apple"), price: Optional(549), discountPercentage: Optional(12.96), rating: Optional(4.69), stock: Optional(94), brand: Optional("Apple"), category: Optional("smartphones"), thumbnail: Optional("https://i.dummyjson.com/data/products/1/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/1/1.jpg", "https://i.dummyjson.com/data/products/1/2.jpg", "https://i.dummyjson.com/data/products/1/3.jpg", "https://i.dummyjson.com/data/products/1/4.jpg", "https://i.dummyjson.com/data/products/1/thumbnail.jpg"])),
        Product(id: 2, title: Optional("iPhone X"), description: Optional("SIM-Free, Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip with ..."), price: Optional(899), discountPercentage: Optional(17.94), rating: Optional(4.44), stock: Optional(34), brand: Optional("Apple"), category: Optional("smartphones"), thumbnail: Optional("https://i.dummyjson.com/data/products/2/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/2/1.jpg", "https://i.dummyjson.com/data/products/2/2.jpg", "https://i.dummyjson.com/data/products/2/3.jpg", "https://i.dummyjson.com/data/products/2/thumbnail.jpg"])),
        Product(id: 3, title: Optional("Samsung Universe 9"), description: Optional("Samsung\'s new variant which goes beyond Galaxy to the Universe"), price: Optional(1249), discountPercentage: Optional(15.46), rating: Optional(4.09), stock: Optional(36), brand: Optional("Samsung"), category: Optional("smartphones"), thumbnail: Optional("https://i.dummyjson.com/data/products/3/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/3/1.jpg"])),
        Product(id: 4, title: Optional("OPPOF19"), description: Optional("OPPO F19 is officially announced on April 2021."), price: Optional(280), discountPercentage: Optional(17.91), rating: Optional(4.3), stock: Optional(123), brand: Optional("OPPO"), category: Optional("smartphones"), thumbnail: Optional("https://i.dummyjson.com/data/products/4/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/4/1.jpg", "https://i.dummyjson.com/data/products/4/2.jpg", "https://i.dummyjson.com/data/products/4/3.jpg", "https://i.dummyjson.com/data/products/4/4.jpg", "https://i.dummyjson.com/data/products/4/thumbnail.jpg"])),
        Product(id: 5, title: Optional("Huawei P30"), description: Optional("Huawei’s re-badged P30 Pro New Edition was officially unveiled yesterday in Germany and now the device has made its way to the UK."), price: Optional(499), discountPercentage: Optional(10.58), rating: Optional(4.09), stock: Optional(32), brand: Optional("Huawei"), category: Optional("smartphones"), thumbnail: Optional("https://i.dummyjson.com/data/products/5/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/5/1.jpg", "https://i.dummyjson.com/data/products/5/2.jpg", "https://i.dummyjson.com/data/products/5/3.jpg"])),
        Product(id: 6, title: Optional("MacBook Pro"), description: Optional("MacBook Pro 2021 with mini-LED display may launch between September, November"), price: Optional(1749), discountPercentage: Optional(11.02), rating: Optional(4.57), stock: Optional(83), brand: Optional("APPle"), category: Optional("laptops"), thumbnail: Optional("https://i.dummyjson.com/data/products/6/thumbnail.png"), images: Optional(["https://i.dummyjson.com/data/products/6/1.png", "https://i.dummyjson.com/data/products/6/2.jpg", "https://i.dummyjson.com/data/products/6/3.png", "https://i.dummyjson.com/data/products/6/4.jpg"])),
        Product(id: 7, title: Optional("Samsung Galaxy Book"), description: Optional("Samsung Galaxy Book S (2020) Laptop With Intel Lakefield Chip, 8GB of RAM Launched"), price: Optional(1499), discountPercentage: Optional(4.15), rating: Optional(4.25), stock: Optional(50), brand: Optional("Samsung"), category: Optional("laptops"), thumbnail: Optional("https://i.dummyjson.com/data/products/7/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/7/1.jpg", "https://i.dummyjson.com/data/products/7/2.jpg", "https://i.dummyjson.com/data/products/7/3.jpg", "https://i.dummyjson.com/data/products/7/thumbnail.jpg"])),
        Product(id: 8, title: Optional("Microsoft Surface Laptop 4"), description: Optional("Style and speed. Stand out on HD video calls backed by Studio Mics. Capture ideas on the vibrant touchscreen."), price: Optional(1499), discountPercentage: Optional(10.23), rating: Optional(4.43), stock: Optional(68), brand: Optional("Microsoft Surface"), category: Optional("laptops"), thumbnail: Optional("https://i.dummyjson.com/data/products/8/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/8/1.jpg", "https://i.dummyjson.com/data/products/8/2.jpg", "https://i.dummyjson.com/data/products/8/3.jpg", "https://i.dummyjson.com/data/products/8/4.jpg", "https://i.dummyjson.com/data/products/8/thumbnail.jpg"])),
        Product(id: 9, title: Optional("Infinix INBOOK"), description: Optional("Infinix Inbook X1 Ci3 10th 8GB 256GB 14 Win10 Grey – 1 Year Warranty"), price: Optional(1099), discountPercentage: Optional(11.83), rating: Optional(4.54), stock: Optional(96), brand: Optional("Infinix"), category: Optional("laptops"), thumbnail: Optional("https://i.dummyjson.com/data/products/9/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/9/1.jpg", "https://i.dummyjson.com/data/products/9/2.png", "https://i.dummyjson.com/data/products/9/3.png", "https://i.dummyjson.com/data/products/9/4.jpg", "https://i.dummyjson.com/data/products/9/thumbnail.jpg"])),
        Product(id: 10, title: Optional("HP Pavilion 15-DK1056WM"), description: Optional("HP Pavilion 15-DK1056WM Gaming Laptop 10th Gen Core i5, 8GB, 256GB SSD, GTX 1650 4GB, Windows 10"), price: Optional(1099), discountPercentage: Optional(6.18), rating: Optional(4.43), stock: Optional(89), brand: Optional("HP Pavilion"), category: Optional("laptops"), thumbnail: Optional("https://i.dummyjson.com/data/products/10/thumbnail.jpeg"), images: Optional(["https://i.dummyjson.com/data/products/10/1.jpg", "https://i.dummyjson.com/data/products/10/2.jpg", "https://i.dummyjson.com/data/products/10/3.jpg", "https://i.dummyjson.com/data/products/10/thumbnail.jpeg"])),
        Product(id: 11, title: Optional("perfume Oil"), description: Optional("Mega Discount, Impression of Acqua Di Gio by GiorgioArmani concentrated attar perfume Oil"), price: Optional(13), discountPercentage: Optional(8.4), rating: Optional(4.26), stock: Optional(65), brand: Optional("Impression of Acqua Di Gio"), category: Optional("fragrances"), thumbnail: Optional("https://i.dummyjson.com/data/products/11/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/11/1.jpg", "https://i.dummyjson.com/data/products/11/2.jpg", "https://i.dummyjson.com/data/products/11/3.jpg", "https://i.dummyjson.com/data/products/11/thumbnail.jpg"])),
        Product(id: 12, title: Optional("Brown Perfume"), description: Optional("Royal_Mirage Sport Brown Perfume for Men & Women - 120ml"), price: Optional(40), discountPercentage: Optional(15.66), rating: Optional(4.0), stock: Optional(52), brand: Optional("Royal_Mirage"), category: Optional("fragrances"), thumbnail: Optional("https://i.dummyjson.com/data/products/12/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/12/1.jpg", "https://i.dummyjson.com/data/products/12/2.jpg", "https://i.dummyjson.com/data/products/12/3.png", "https://i.dummyjson.com/data/products/12/4.jpg", "https://i.dummyjson.com/data/products/12/thumbnail.jpg"])),
        Product(id: 13, title: Optional("Fog Scent Xpressio Perfume"), description: Optional("Product details of Best Fog Scent Xpressio Perfume 100ml For Men cool long lasting perfumes for Men"), price: Optional(13), discountPercentage: Optional(8.14), rating: Optional(4.59), stock: Optional(61), brand: Optional("Fog Scent Xpressio"), category: Optional("fragrances"), thumbnail: Optional("https://i.dummyjson.com/data/products/13/thumbnail.webp"), images: Optional(["https://i.dummyjson.com/data/products/13/1.jpg", "https://i.dummyjson.com/data/products/13/2.png", "https://i.dummyjson.com/data/products/13/3.jpg", "https://i.dummyjson.com/data/products/13/4.jpg", "https://i.dummyjson.com/data/products/13/thumbnail.webp"])),
        Product(id: 14, title: Optional("Non-Alcoholic Concentrated Perfume Oil"), description: Optional("Original Al Munakh® by Mahal Al Musk | Our Impression of Climate | 6ml Non-Alcoholic Concentrated Perfume Oil"), price: Optional(120), discountPercentage: Optional(15.6), rating: Optional(4.21), stock: Optional(114), brand: Optional("Al Munakh"), category: Optional("fragrances"), thumbnail: Optional("https://i.dummyjson.com/data/products/14/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/14/1.jpg", "https://i.dummyjson.com/data/products/14/2.jpg", "https://i.dummyjson.com/data/products/14/3.jpg", "https://i.dummyjson.com/data/products/14/thumbnail.jpg"])),
        Product(id: 15, title: Optional("Eau De Perfume Spray"), description: Optional("Genuine  Al-Rehab spray perfume from UAE/Saudi Arabia/Yemen High Quality"), price: Optional(30), discountPercentage: Optional(10.99), rating: Optional(4.7), stock: Optional(105), brand: Optional("Lord - Al-Rehab"), category: Optional("fragrances"), thumbnail: Optional("https://i.dummyjson.com/data/products/15/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/15/1.jpg", "https://i.dummyjson.com/data/products/15/2.jpg", "https://i.dummyjson.com/data/products/15/3.jpg", "https://i.dummyjson.com/data/products/15/4.jpg", "https://i.dummyjson.com/data/products/15/thumbnail.jpg"])),
        Product(id: 16, title: Optional("Hyaluronic Acid Serum"), description: Optional("L\'OrÃ©al Paris introduces Hyaluron Expert Replumping Serum formulated with 1.5% Hyaluronic Acid"), price: Optional(19), discountPercentage: Optional(13.31), rating: Optional(4.83), stock: Optional(110), brand: Optional("L\'Oreal Paris"), category: Optional("skincare"), thumbnail: Optional("https://i.dummyjson.com/data/products/16/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/16/1.png", "https://i.dummyjson.com/data/products/16/2.webp", "https://i.dummyjson.com/data/products/16/3.jpg", "https://i.dummyjson.com/data/products/16/4.jpg", "https://i.dummyjson.com/data/products/16/thumbnail.jpg"])),
        Product(id: 17, title: Optional("Tree Oil 30ml"), description: Optional("Tea tree oil contains a number of compounds, including terpinen-4-ol, that have been shown to kill certain bacteria,"), price: Optional(12), discountPercentage: Optional(4.09), rating: Optional(4.52), stock: Optional(78), brand: Optional("Hemani Tea"), category: Optional("skincare"), thumbnail: Optional("https://i.dummyjson.com/data/products/17/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/17/1.jpg", "https://i.dummyjson.com/data/products/17/2.jpg", "https://i.dummyjson.com/data/products/17/3.jpg", "https://i.dummyjson.com/data/products/17/thumbnail.jpg"])),
        Product(id: 18, title: Optional("Oil Free Moisturizer 100ml"), description: Optional("Dermive Oil Free Moisturizer with SPF 20 is specifically formulated with ceramides, hyaluronic acid & sunscreen."), price: Optional(40), discountPercentage: Optional(13.1), rating: Optional(4.56), stock: Optional(88), brand: Optional("Dermive"), category: Optional("skincare"), thumbnail: Optional("https://i.dummyjson.com/data/products/18/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/18/1.jpg", "https://i.dummyjson.com/data/products/18/2.jpg", "https://i.dummyjson.com/data/products/18/3.jpg", "https://i.dummyjson.com/data/products/18/4.jpg", "https://i.dummyjson.com/data/products/18/thumbnail.jpg"])),
        Product(id: 19, title: Optional("Skin Beauty Serum."), description: Optional("Product name: rorec collagen hyaluronic acid white face serum riceNet weight: 15 m"), price: Optional(46), discountPercentage: Optional(10.68), rating: Optional(4.42), stock: Optional(54), brand: Optional("ROREC White Rice"), category: Optional("skincare"), thumbnail: Optional("https://i.dummyjson.com/data/products/19/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/19/1.jpg", "https://i.dummyjson.com/data/products/19/2.jpg", "https://i.dummyjson.com/data/products/19/3.png", "https://i.dummyjson.com/data/products/19/thumbnail.jpg"])),
        Product(id: 20, title: Optional("Freckle Treatment Cream- 15gm"), description: Optional("Fair & Clear is Pakistan\'s only pure Freckle cream which helpsfade Freckles, Darkspots and pigments. Mercury level is 0%, so there are no side effects."), price: Optional(70), discountPercentage: Optional(16.99), rating: Optional(4.06), stock: Optional(140), brand: Optional("Fair & Clear"), category: Optional("skincare"), thumbnail: Optional("https://i.dummyjson.com/data/products/20/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/20/1.jpg", "https://i.dummyjson.com/data/products/20/2.jpg", "https://i.dummyjson.com/data/products/20/3.jpg", "https://i.dummyjson.com/data/products/20/4.jpg", "https://i.dummyjson.com/data/products/20/thumbnail.jpg"])),
        Product(id: 21, title: Optional("- Daal Masoor 500 grams"), description: Optional("Fine quality Branded Product Keep in a cool and dry place"), price: Optional(20), discountPercentage: Optional(4.81), rating: Optional(4.44), stock: Optional(133), brand: Optional("Saaf & Khaas"), category: Optional("groceries"), thumbnail: Optional("https://i.dummyjson.com/data/products/21/thumbnail.png"), images: Optional(["https://i.dummyjson.com/data/products/21/1.png", "https://i.dummyjson.com/data/products/21/2.jpg", "https://i.dummyjson.com/data/products/21/3.jpg"])),
        Product(id: 22, title: Optional("Elbow Macaroni - 400 gm"), description: Optional("Product details of Bake Parlor Big Elbow Macaroni - 400 gm"), price: Optional(14), discountPercentage: Optional(15.58), rating: Optional(4.57), stock: Optional(146), brand: Optional("Bake Parlor Big"), category: Optional("groceries"), thumbnail: Optional("https://i.dummyjson.com/data/products/22/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/22/1.jpg", "https://i.dummyjson.com/data/products/22/2.jpg", "https://i.dummyjson.com/data/products/22/3.jpg"])),
        Product(id: 23, title: Optional("Orange Essence Food Flavou"), description: Optional("Specifications of Orange Essence Food Flavour For Cakes and Baking Food Item"), price: Optional(14), discountPercentage: Optional(8.04), rating: Optional(4.85), stock: Optional(26), brand: Optional("Baking Food Items"), category: Optional("groceries"), thumbnail: Optional("https://i.dummyjson.com/data/products/23/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/23/1.jpg", "https://i.dummyjson.com/data/products/23/2.jpg", "https://i.dummyjson.com/data/products/23/3.jpg", "https://i.dummyjson.com/data/products/23/4.jpg", "https://i.dummyjson.com/data/products/23/thumbnail.jpg"])),
        Product(id: 24, title: Optional("cereals muesli fruit nuts"), description: Optional("original fauji cereal muesli 250gm box pack original fauji cereals muesli fruit nuts flakes breakfast cereal break fast faujicereals cerels cerel foji fouji"), price: Optional(46), discountPercentage: Optional(16.8), rating: Optional(4.94), stock: Optional(113), brand: Optional("fauji"), category: Optional("groceries"), thumbnail: Optional("https://i.dummyjson.com/data/products/24/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/24/1.jpg", "https://i.dummyjson.com/data/products/24/2.jpg", "https://i.dummyjson.com/data/products/24/3.jpg", "https://i.dummyjson.com/data/products/24/4.jpg", "https://i.dummyjson.com/data/products/24/thumbnail.jpg"])),
        Product(id: 25, title: Optional("Gulab Powder 50 Gram"), description: Optional("Dry Rose Flower Powder Gulab Powder 50 Gram • Treats Wounds"), price: Optional(70), discountPercentage: Optional(13.58), rating: Optional(4.87), stock: Optional(47), brand: Optional("Dry Rose"), category: Optional("groceries"), thumbnail: Optional("https://i.dummyjson.com/data/products/25/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/25/1.png", "https://i.dummyjson.com/data/products/25/2.jpg", "https://i.dummyjson.com/data/products/25/3.png", "https://i.dummyjson.com/data/products/25/4.jpg", "https://i.dummyjson.com/data/products/25/thumbnail.jpg"])),
        Product(id: 26, title: Optional("Plant Hanger For Home"), description: Optional("Boho Decor Plant Hanger For Home Wall Decoration Macrame Wall Hanging Shelf"), price: Optional(41), discountPercentage: Optional(17.86), rating: Optional(4.08), stock: Optional(131), brand: Optional("Boho Decor"), category: Optional("home-decoration"), thumbnail: Optional("https://i.dummyjson.com/data/products/26/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/26/1.jpg", "https://i.dummyjson.com/data/products/26/2.jpg", "https://i.dummyjson.com/data/products/26/3.jpg", "https://i.dummyjson.com/data/products/26/4.jpg", "https://i.dummyjson.com/data/products/26/5.jpg", "https://i.dummyjson.com/data/products/26/thumbnail.jpg"])),
        Product(id: 27, title: Optional("Flying Wooden Bird"), description: Optional("Package Include 6 Birds with Adhesive Tape Shape: 3D Shaped Wooden Birds Material: Wooden MDF, Laminated 3.5mm"), price: Optional(51), discountPercentage: Optional(15.58), rating: Optional(4.41), stock: Optional(17), brand: Optional("Flying Wooden"), category: Optional("home-decoration"), thumbnail: Optional("https://i.dummyjson.com/data/products/27/thumbnail.webp"), images: Optional(["https://i.dummyjson.com/data/products/27/1.jpg", "https://i.dummyjson.com/data/products/27/2.jpg", "https://i.dummyjson.com/data/products/27/3.jpg", "https://i.dummyjson.com/data/products/27/4.jpg", "https://i.dummyjson.com/data/products/27/thumbnail.webp"])),
        Product(id: 28, title: Optional("3D Embellishment Art Lamp"), description: Optional("3D led lamp sticker Wall sticker 3d wall art light on/off button  cell operated (included)"), price: Optional(20), discountPercentage: Optional(16.49), rating: Optional(4.82), stock: Optional(54), brand: Optional("LED Lights"), category: Optional("home-decoration"), thumbnail: Optional("https://i.dummyjson.com/data/products/28/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/28/1.jpg", "https://i.dummyjson.com/data/products/28/2.jpg", "https://i.dummyjson.com/data/products/28/3.png", "https://i.dummyjson.com/data/products/28/4.jpg", "https://i.dummyjson.com/data/products/28/thumbnail.jpg"])),
        Product(id: 29, title: Optional("Handcraft Chinese style"), description: Optional("Handcraft Chinese style art luxury palace hotel villa mansion home decor ceramic vase with brass fruit plate"), price: Optional(60), discountPercentage: Optional(15.34), rating: Optional(4.44), stock: Optional(7), brand: Optional("luxury palace"), category: Optional("home-decoration"), thumbnail: Optional("https://i.dummyjson.com/data/products/29/thumbnail.webp"), images: Optional(["https://i.dummyjson.com/data/products/29/1.jpg", "https://i.dummyjson.com/data/products/29/2.jpg", "https://i.dummyjson.com/data/products/29/3.webp", "https://i.dummyjson.com/data/products/29/4.webp", "https://i.dummyjson.com/data/products/29/thumbnail.webp"])),
        Product(id: 30, title: Optional("Key Holder"), description: Optional("Attractive DesignMetallic materialFour key hooksReliable & DurablePremium Quality"), price: Optional(30), discountPercentage: Optional(2.92), rating: Optional(4.92), stock: Optional(54), brand: Optional("Golden"), category: Optional("home-decoration"), thumbnail: Optional("https://i.dummyjson.com/data/products/30/thumbnail.jpg"), images: Optional(["https://i.dummyjson.com/data/products/30/1.jpg", "https://i.dummyjson.com/data/products/30/2.jpg", "https://i.dummyjson.com/data/products/30/3.jpg", "https://i.dummyjson.com/data/products/30/thumbnail.jpg"]))
    ]
    
}
