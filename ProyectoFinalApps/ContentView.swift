//
//  ContentView.swift
//  ProyectoFinal
//
//  Created by Diego Heredia on 26/05/23.
//

import SwiftUI


struct Album {
    let id: Int
    let name: String
    let artist: String
    let image: String
}

struct Song {
    let id: Int
    let name: String
    let image: String
    let artist: String
}
struct Playlist {
    let id: Int
    let name: String
    let image: String
    let author: String
}
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        let hashIndex = hex.index(hex.startIndex, offsetBy: 1)
        scanner.currentIndex = hashIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


struct ContentView: View {
    init() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = UIColor.clear

            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithTransparentBackground()
            tabBarAppearance.backgroundColor = UIColor(hex: "#121212")
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().unselectedItemTintColor = UIColor(hex: "#B3B3B3")
        }

    @State private var selectedTab = 0

    var body: some View {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        TabBarItemView(selectedTab: $selectedTab, tab: 0, iconName: "house.fill", tabName: "Home")
                    }
                    .tag(0)
                SearchView()
                    .tabItem {
                        TabBarItemView(selectedTab: $selectedTab, tab: 1, iconName: "magnifyingglass", tabName: "Search")
                    }
                    .tag(1)
                LibraryView()
                    .tabItem {
                        TabBarItemView(selectedTab: $selectedTab, tab: 2, iconName: "books.vertical.fill", tabName: "Library")
                    }
                    .tag(2)
            }
            .accentColor(.white)
        }
}

struct TabBarItemView: View {
    @Binding var selectedTab: Int
    let tab: Int
    let iconName: String
    let tabName: String

    var body: some View {
        VStack {
            Image(systemName: iconName)
            Text(tabName)
        }
        .foregroundColor(selectedTab == tab ? .white : .gray)
    }
}
struct PillButton: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(Color(hex: "#292929"))
            .foregroundColor(.white)
            .cornerRadius(25)
    }
}
struct HomeView: View {
    let albums = [
        Album(id: 1, name: "Mr. Morale & The Big Steppers", artist: "Kendrick Lamar", image: "album1"),
        Album(id: 2, name: "Melodrama", artist: "Lorde", image: "album2"),
        Album(id: 3, name: "My beautiful Dark Twited Fantasy", artist: "Kanye West", image: "album3"),
        
    ]
   
    let playlists = [
        Playlist(id: 1, name: "Timelines", image: "playlist1", author: "monicatab"),
        Playlist(id: 2, name: "This is Kendrick Lamar", image: "playlist2", author: "Spotify"),
        Playlist(id: 3, name: "Lorde", image: "playlist3", author: "monicatab"),
        Playlist(id: 4, name: "Corrido Tumbados", image: "playlist4", author: "monicatab"),
        Playlist(id: 5, name: "🤍", image: "playlist5", author: "monicatab"),
        Playlist(id: 6, name: "💊", image: "playlist6", author: "Diego"),
        
    ]
    
    // Define the layout for the grid
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Buenos días")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 10)
                       
                        
                        HStack {
                                           PillButton(title: "Music")
                                           PillButton(title: "Podcasts & Shows")
                                       }
                                       .padding(.vertical, 10)
                        
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(playlists, id: \.id) { playlist in
                                HStack {
                                    Image(playlist.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .cornerRadius(4)
                                    Text(playlist.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .padding([.leading, .trailing], 10)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                                .padding()
                                .background(Color(hex: "#292929"))
                                .cornerRadius(8)
                            }
                        }
                        Text("Trending Albums")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        ForEach(albums, id: \.id) { album in
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(album.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(4)

                                    VStack(alignment: .leading) {
                                        Text(album.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(album.artist)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                Divider().background(Color.white)
                            }
                        }
                        
                    


                    }
                    .padding()
                }
            }
        }
    }
}


struct SearchView: View {
    @State private var searchText = ""

    // Define the layout for the grid
    let columns = [
        GridItem(.fixed(150), spacing: 10),
        GridItem(.fixed(150), spacing: 10)
    ]
    let categories = [
        ("Pop     ", Color.red),
        ("Rock", Color.blue),
        ("Country", Color.green),
        ("Hip Hop", Color.purple),
        ("Classical", Color.orange),
        ("Electronic", Color.pink),
        ("Reggae", Color.brown),
        ("Blues", Color.gray),
       
    ]


    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack (alignment: .leading){
                Text("Search")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 10)
                SearchBar(text: $searchText)
                    .padding(.top, 10)
                Text("Browse All")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 20)
                ScrollView {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(categories, id: \.0) { category in
                                    CategoryCard(categoryName: category.0, backgroundColor: category.1).frame(width: 300, height: 100)
                                }
                            }
                            .padding(.horizontal)
                        }
                Spacer()
            }.padding(.horizontal)
        }
        .navigationBarTitle("Search", displayMode: .inline)
    }
}




struct CategoryCard: View {
    var categoryName: String
    var backgroundColor: Color

    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.all, 20)
            Spacer()
        }
        .background(backgroundColor)
        .cornerRadius(8)
        
        
    }
}


struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .foregroundColor(.black)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if text != "" {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
        }
        .foregroundColor(.white)
    }
}


struct LibraryView: View {
    let albums = [
        Album(id: 1, name: "Mr. Morale & The Big Steppers", artist: "Kendrick Lamar", image: "album1"),
        Album(id: 2, name: "Melodrama", artist: "Lorde", image: "album2"),
        Album(id: 3, name: "My beautiful Dark Twited Fantasy", artist: "Kanye West", image: "album3"),
        
    ]
    let songs = [
        Song(id: 1, name: "Money Trees", image: "song1",artist: "Kendrick Lamar"),
        Song(id: 2, name: "Les", image: "song2",artist: "Childish Gambino"),
        Song(id: 3, name: "Die Hard", image: "song3",artist: "Kendrick Lamar"),
        
    ]
    let playlists = [
        Playlist(id: 1, name: "Timelines", image: "playlist1", author: "monicatab"),
        Playlist(id: 2, name: "This is Kendrick Lamar", image: "playlist2", author: "Spotify"),
        Playlist(id: 3, name: "Lorde", image: "playlist3", author: "monicatab"),
        Playlist(id: 4, name: "Corrido Tumbados", image: "playlist4", author: "monicatab"),
        Playlist(id: 5, name: "🤍", image: "playlist5", author: "monicatab"),
        Playlist(id: 6, name: "💊", image: "playlist6", author: "Diego"),
        
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                                                    Text("Your Library")
                                                        .font(.largeTitle)
                                                        .bold()
                                                        .foregroundColor(.white)
                                                    
                                                    Spacer() // Pushes the following items to the right

                                                    Image(systemName: "magnifyingglass")
                                                        .foregroundColor(.white)
                                                        .padding(.trailing, 10) // Adds some space between the icons
                                                    
                                                    Image(systemName: "plus")
                                                        .foregroundColor(.white)
                                                }
                                                .padding(.top, 5)
                                              ScrollView(.horizontal, showsIndicators: false) {
                                                  HStack(spacing: 15) {
                                                      PillButton(title: "Playlists")
                                                      PillButton(title: "Podcasts & Shows")
                                                      PillButton(title: "Albums")
                                                      PillButton(title: "Downloaded")
                                                  }
                                                  .padding(.vertical, 5)
                                              }

                                               // Aquí se muestran las playlists:
                                               ForEach(playlists, id: \.id) { playlist in
                                                   HStack {
                                                       Image(playlist.image)
                                                           .resizable()
                                                           .aspectRatio(contentMode: .fit)
                                                           .frame(width: 80, height: 80)
                                                           .cornerRadius(4)

                                                       VStack(alignment: .leading) {
                                                           Text(playlist.name)
                                                               .font(.headline)
                                                               .foregroundColor(.white)
                                                           Text("Playlist - \(playlist.author)")
                                                               .font(.subheadline)
                                                               .foregroundColor(.gray)
                                                       }
                                                   }
                                                   Divider().background(Color.white)
                                               }
                        Text("Favourite Albums")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        ForEach(albums, id: \.id) { album in
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(album.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(4)

                                    VStack(alignment: .leading) {
                                        Text(album.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(album.artist)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                Divider().background(Color.white)
                            }
                        }
                        Text("Favourite Songs")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        ForEach(songs, id: \.id) { song in
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(song.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(4)

                                    VStack(alignment: .leading) {
                                        Text(song.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(song.artist)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                Divider().background(Color.white)
                            }
                        }
                    }
                    .padding()
                }
            }
            
        }
    }
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
