import SwiftUI

// MARK: - Main App Entry Point
// This is where the app starts. It sets up the main window and
// displays our primary view, ContentView.
@main
struct ChatAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - Data Model
// A simple structure to represent a single chat session.
// It's 'Identifiable' so SwiftUI can uniquely identify each chat in a list.
struct Chat: Identifiable {
    let id = UUID() // Unique identifier for each chat
    let title: String
    let timestamp: String
    let iconName: String // SFSymbol name for the chat icon
}

// MARK: - Main Content View
// This view acts as the main container for our app, setting up the
// TabView for bottom navigation.
struct ContentView: View {
    var body: some View {
        // TabView creates the bottom navigation bar.
        TabView {
            // -- HOME TAB --
            HomeView()
                .tabItem {
                    Label("Chats", systemImage: "message.fill")
                }

            // -- EXPLORE TAB (Placeholder) --
            PlaceholderView(text: "Explore", icon: "safari.fill")
                .tabItem {
                    Label("Explore", systemImage: "safari.fill")
                }
            
            // -- SETTINGS TAB (Placeholder) --
            PlaceholderView(text: "Settings", icon: "gearshape.fill")
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        // Sets the accent color for the selected tab item
        .accentColor(.white)
    }
}

// MARK: - Home Screen View
// This is the main screen, showing the list of chats.
struct HomeView: View {
    
    // Sample data for demonstration purposes. In a real app, this
    // would come from a database or an API.
    let chats: [Chat] = [
        Chat(title: "Creative Writing Session", timestamp: "3 hours ago", iconName: "pencil.and.outline"),
        Chat(title: "iOS Development Help", timestamp: "Yesterday", iconName: "swift"),
        Chat(title: "Recipe Ideas", timestamp: "2 days ago", iconName: "fork.knife"),
        Chat(title: "Vacation Planning", timestamp: "Last week", iconName: "beach.umbrella.fill"),
        Chat(title: "Workout Routine", timestamp: "May 15", iconName: "figure.run")
    ]

    var body: some View {
        // NavigationView provides the top bar and allows for navigation stacks.
        NavigationView {
            // ZStack layers views on top of each other. Used here for the background color.
            ZStack {
                // Background Color
                Color.black.ignoresSafeArea()

                // Main content laid out vertically
                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        HeaderView()

                        // "Start New Chat" Button
                        Button(action: {
                            // Action for starting a new chat
                            print("Start new chat tapped!")
                        }) {
                            Label("Start new chat", systemImage: "plus")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)

                        // "Recent Chats" Title
                        HStack {
                            Text("Recent Chats")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        // List of recent chats
                        VStack(spacing: 12) {
                            ForEach(chats) { chat in
                                ChatRowView(chat: chat)
                            }
                        }
                        .padding(.horizontal)

                    }
                    .padding(.top)
                }
            }
            .navigationBarHidden(true) // We use a custom header instead of the default.
        }
        // Sets the color scheme for the entire navigation view to dark
        .environment(\.colorScheme, .dark)
    }
}

// MARK: - Reusable UI Components

// The header view with the app logo and title
struct HeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "pawprint.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.blue)
            
            Text("PawsAI")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}


// A view for a single row in the chat list
struct ChatRowView: View {
    let chat: Chat

    var body: some View {
        HStack(spacing: 15) {
            // Chat Icon
            Image(systemName: chat.iconName)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 30)

            // Chat Title and Timestamp
            VStack(alignment: .leading, spacing: 4) {
                Text(chat.title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(chat.timestamp)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            // More Options Button
            Image(systemName: "ellipsis")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

// A placeholder view for tabs that are not yet implemented
struct PlaceholderView: View {
    let text: String
    let icon: String
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 20) {
                Image(systemName: icon)
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                Text(text)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
}


// MARK: - SwiftUI Preview
// This allows you to see a live preview of your UI in Xcode.
// It doesn't affect the final app.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
