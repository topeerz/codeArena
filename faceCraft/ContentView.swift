import SwiftUI

struct ContentView: View {
    @StateObject private var imageGenerator = ImageGenerator()
    @State private var showAnimeGirl = false
    @State private var isGenerating = false
    @State private var errorMessage: String?
    
    var body: some View {
        ZStack {
            // Background color
            Color.black.edgesIgnoringSafeArea(.all)
            
            if let image = imageGenerator.generatedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity.animation(.easeInOut(duration: 0.5)))
            }
            
            VStack {
                Spacer()
                
                if isGenerating {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                        .padding()
                }
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Generate button
                Button(action: {
                    Task {
                        isGenerating = true
                        errorMessage = nil
                        
                        do {
                            let image = try await imageGenerator.generateImage()
                            withAnimation {
                                imageGenerator.generatedImage = image
                                showAnimeGirl = true
                            }
                        } catch {
                            errorMessage = "Error: \(error.localizedDescription)"
                        }
                        
                        isGenerating = false
                    }
                }) {
                    Text(isGenerating ? "Generating..." : "Generate Anime Girl")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(isGenerating ? Color.gray : Color.pink)
                                .shadow(radius: 5)
                        )
                }
                .disabled(isGenerating)
                .padding(.bottom, 50)
            }
        }
        .statusBar(hidden: true)
    }
}

#Preview {
    ContentView()
}
