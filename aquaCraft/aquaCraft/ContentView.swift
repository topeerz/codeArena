//
//  ContentView.swift
//  labObservable
//
//  Created by topeerz on 14/11/2024.
//

import Observation
import SwiftUI

@Observable
class VM: ObservableObject {
    var loading: Bool = true
    var clicks: Int = 0
}

struct ContentView: View {
    @StateObject var vm = VM()
    
    var body: some View {
        ZStack {
            if vm.loading {
                FishLoadingView(vm: vm)
                    .transition(.opacity)
            } else {
                MainView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: vm.loading)
    }
}

enum MarineSpecies: String, CaseIterable {
    case fish = "fish"
    case fishFill = "fish.fill"
    case fishCircle = "fish.circle"
    case fishCircleFill = "fish.circle.fill"
    case whaleFill = "seal.fill"
}

enum FishShape: CaseIterable {
    case slenderFish
    case roundFish
    case longFish
    case fatFish
    case tinyFish
}

struct SlenderFish: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Body
        path.move(to: CGPoint(x: width * 0.15, y: height * 0.5))
        path.addCurve(
            to: CGPoint(x: width * 0.85, y: height * 0.5),
            control1: CGPoint(x: width * 0.4, y: height * 0.3),
            control2: CGPoint(x: width * 0.7, y: height * 0.4)
        )
        path.addCurve(
            to: CGPoint(x: width * 0.15, y: height * 0.5),
            control1: CGPoint(x: width * 0.7, y: height * 0.6),
            control2: CGPoint(x: width * 0.4, y: height * 0.7)
        )
        
        // Dorsal fin
        path.move(to: CGPoint(x: width * 0.5, y: height * 0.35))
        path.addQuadCurve(
            to: CGPoint(x: width * 0.6, y: height * 0.35),
            control: CGPoint(x: width * 0.55, y: height * 0.2)
        )
        
        // Pectoral fin
        path.move(to: CGPoint(x: width * 0.35, y: height * 0.5))
        path.addQuadCurve(
            to: CGPoint(x: width * 0.4, y: height * 0.6),
            control: CGPoint(x: width * 0.3, y: height * 0.65)
        )
        
        return path
    }
}

struct RoundFish: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Rounder body
        path.move(to: CGPoint(x: width * 0.2, y: height * 0.5))
        path.addCurve(
            to: CGPoint(x: width * 0.8, y: height * 0.5),
            control1: CGPoint(x: width * 0.4, y: height * 0.2),
            control2: CGPoint(x: width * 0.6, y: height * 0.2)
        )
        path.addCurve(
            to: CGPoint(x: width * 0.2, y: height * 0.5),
            control1: CGPoint(x: width * 0.6, y: height * 0.8),
            control2: CGPoint(x: width * 0.4, y: height * 0.8)
        )
        
        // Dorsal fin
        path.move(to: CGPoint(x: width * 0.45, y: height * 0.3))
        path.addQuadCurve(
            to: CGPoint(x: width * 0.55, y: height * 0.3),
            control: CGPoint(x: width * 0.5, y: height * 0.15)
        )
        
        // Pectoral fin
        path.move(to: CGPoint(x: width * 0.35, y: height * 0.5))
        path.addQuadCurve(
            to: CGPoint(x: width * 0.4, y: height * 0.65),
            control: CGPoint(x: width * 0.3, y: height * 0.7)
        )
        
        return path
    }
}

struct LongFish: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Elongated body
        path.move(to: CGPoint(x: width * 0.1, y: height * 0.5))
        path.addCurve(
            to: CGPoint(x: width * 0.9, y: height * 0.5),
            control1: CGPoint(x: width * 0.3, y: height * 0.3),
            control2: CGPoint(x: width * 0.8, y: height * 0.4)
        )
        path.addCurve(
            to: CGPoint(x: width * 0.1, y: height * 0.5),
            control1: CGPoint(x: width * 0.8, y: height * 0.6),
            control2: CGPoint(x: width * 0.3, y: height * 0.7)
        )
        
        // Long dorsal fin
        path.move(to: CGPoint(x: width * 0.4, y: height * 0.35))
        path.addQuadCurve(
            to: CGPoint(x: width * 0.7, y: height * 0.35),
            control: CGPoint(x: width * 0.55, y: height * 0.15)
        )
        
        // Streamlined pectoral fin
        path.move(to: CGPoint(x: width * 0.3, y: height * 0.5))
        path.addQuadCurve(
            to: CGPoint(x: width * 0.4, y: height * 0.6),
            control: CGPoint(x: width * 0.25, y: height * 0.65)
        )
        
        return path
    }
}

struct FatFish: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Wide body
        path.move(to: CGPoint(x: width * 0.2, y: height * 0.5))
        path.addCurve(
            to: CGPoint(x: width * 0.75, y: height * 0.5),
            control1: CGPoint(x: width * 0.4, y: height * 0.1),
            control2: CGPoint(x: width * 0.6, y: height * 0.1)
        )
        path.addCurve(
            to: CGPoint(x: width * 0.2, y: height * 0.5),
            control1: CGPoint(x: width * 0.6, y: height * 0.9),
            control2: CGPoint(x: width * 0.4, y: height * 0.9)
        )
        
        // Large dorsal fin
        path.move(to: CGPoint(x: width * 0.4, y: height * 0.25))
        path.addQuadCurve(
            to: CGPoint(x: width * 0.6, y: height * 0.25),
            control: CGPoint(x: width * 0.5, y: height * 0.1)
        )
        
        // Wide pectoral fin
        path.move(to: CGPoint(x: width * 0.35, y: height * 0.5))
        path.addQuadCurve(
            to: CGPoint(x: width * 0.45, y: height * 0.7),
            control: CGPoint(x: width * 0.3, y: height * 0.75)
        )
        
        return path
    }
}

struct TinyFish: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Small compact body
        path.move(to: CGPoint(x: width * 0.3, y: height * 0.5))
        path.addCurve(
            to: CGPoint(x: width * 0.7, y: height * 0.5),
            control1: CGPoint(x: width * 0.4, y: height * 0.3),
            control2: CGPoint(x: width * 0.6, y: height * 0.3)
        )
        path.addCurve(
            to: CGPoint(x: width * 0.3, y: height * 0.5),
            control1: CGPoint(x: width * 0.6, y: height * 0.7),
            control2: CGPoint(x: width * 0.4, y: height * 0.7)
        )
        
        // Small dorsal fin
        path.move(to: CGPoint(x: width * 0.45, y: height * 0.35))
        path.addQuadCurve(
            to: CGPoint(x: width * 0.55, y: height * 0.35),
            control: CGPoint(x: width * 0.5, y: height * 0.25)
        )
        
        // Tiny pectoral fin
        path.move(to: CGPoint(x: width * 0.4, y: height * 0.5))
        path.addQuadCurve(
            to: CGPoint(x: width * 0.45, y: height * 0.6),
            control: CGPoint(x: width * 0.35, y: height * 0.65)
        )
        
        return path
    }
}

struct CustomFishView: View {
    let fishType: FishShape
    let color: Color
    let isDead: Bool
    @State private var isBlinking = false
    @State private var tailOffset = 0.0
    
    init(fishType: FishShape, color: Color, isDead: Bool = false) {
        self.fishType = fishType
        self.color = color
        self.isDead = isDead
    }
    
    private var tailShape: some Shape {
        Triangle()
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            ZStack {
                if isDead {
                    // Skeleton fish body outline
                    AnyShape(fishBody)
                        .stroke(Color.white, lineWidth: 1.5)
                    
                    // Skeleton bones
                    Path { path in
                        // Spine
                        path.move(to: CGPoint(x: width * 0.2, y: height * 0.5))
                        path.addLine(to: CGPoint(x: width * 0.8, y: height * 0.5))
                        
                        // Vertical bones
                        for x in stride(from: 0.3, through: 0.7, by: 0.15) {
                            path.move(to: CGPoint(x: width * x, y: height * 0.3))
                            path.addLine(to: CGPoint(x: width * x, y: height * 0.7))
                        }
                    }
                    .stroke(Color.white, lineWidth: 1.5)
                    
                    // Skeleton tail
                    tailShape
                        .stroke(Color.white, lineWidth: 1.5)
                        .frame(width: width * 0.2, height: height * 0.4)
                        .position(x: width * 0.85, y: height * 0.5)
                    
                    // Skeleton eye socket
                    Circle()
                        .stroke(Color.white, lineWidth: 1.5)
                        .frame(width: width * 0.1, height: width * 0.1)
                        .position(x: width * 0.35, y: height * 0.45)
                } else {
                    // Fish body
                    AnyShape(fishBody)
                        .fill(color)
                    
                    // Tail with animation
                    tailShape
                        .fill(color)
                        .frame(width: width * 0.2, height: height * 0.4)
                        .position(x: width * 0.85, y: height * 0.5)
                        .rotationEffect(.degrees(tailOffset))
                    
                    Group {
                        // Fish eye (white part)
                        Circle()
                            .fill(Color.white)
                            .frame(width: width * 0.1, height: width * 0.1)
                            .position(x: width * 0.35, y: height * 0.45)
                        
                        // Fish pupil (black part)
                        Circle()
                            .fill(Color.black)
                            .frame(width: width * 0.05, height: width * 0.05)
                            .position(x: width * 0.35, y: height * 0.45)
                        
                        // Upper eyelid
                        Rectangle()
                            .fill(color.opacity(1))
                            .frame(width: width * 0.12, height: width * 0.06)
                            .position(x: width * 0.35, y: height * 0.42)
                            .rotationEffect(.degrees(isBlinking ? 0 : -90))
                            .animation(.spring(response: 0.1, dampingFraction: 0.8), value: isBlinking)
                        
                        // Lower eyelid
                        Rectangle()
                            .fill(color.opacity(1))
                            .frame(width: width * 0.12, height: width * 0.06)
                            .position(x: width * 0.35, y: height * 0.48)
                            .rotationEffect(.degrees(isBlinking ? 0 : 90))
                            .animation(.spring(response: 0.1, dampingFraction: 0.8), value: isBlinking)
                    }
                    .zIndex(1)
                }
            }
            .onAppear {
                if !isDead {
                    startBlinking()
                    startTailAnimation()
                }
            }
        }
    }
    
    private func startTailAnimation() {
        withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
            tailOffset = 20
        }
    }
    
    private func startBlinking() {
        // Random interval between 2 and 5 seconds
        let interval = Double.random(in: 2...5)
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            // Blink animation
            withAnimation {
                isBlinking = true
            }
            // Reset after short duration
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation {
                    isBlinking = false
                }
                // Continue blinking
                startBlinking()
            }
        }
    }
    
    private var fishBody: any Shape {
        switch fishType {
        case .slenderFish:
            return SlenderFish()
        case .roundFish:
            return RoundFish()
        case .longFish:
            return LongFish()
        case .fatFish:
            return FatFish()
        case .tinyFish:
            return TinyFish()
        }
    }
}

struct MarineCreatureView: View {
    let species: MarineSpecies
    let color: Color
    
    var body: some View {
        Image(systemName: species.rawValue)
            .resizable()
            .foregroundColor(color)
            .aspectRatio(contentMode: .fit)
            .symbolRenderingMode(.hierarchical)
    }
}

struct FishLoadingView: View {
    @State private var fishCount: Int = 0
    @State private var rotations: [Double] = []
    @State private var positions: [(CGFloat, CGFloat)] = []
    @State private var sizes: [CGFloat] = []
    @State private var scales: [CGFloat] = []
    @State private var isAlive: [Bool] = []
    @State private var fishColors: [Int] = []
    @State private var fishTypes: [FishShape] = []
    @State private var rotationSpeeds: [Double] = []
    @State private var bubbles: [(position: CGPoint, scale: CGFloat, createdAt: Date)] = []
    @State private var deadFish: [(type: FishShape, position: CGPoint, rotation: Double, size: CGFloat, createdAt: Date)] = []
    @State private var tapEffects: [(position: CGPoint, createdAt: Date)] = []
    
    let colors: [Color] = [.blue, .orange, .green, .purple, .red]
    let collisionTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let cleanupTimer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    let growthTimer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    var vm: VM
    
    let maxFishSize: CGFloat = 150 // Maximum size before popping
    let growthRate: CGFloat = 2 // Points to grow every 0.5 seconds
    
    init(vm: VM) {
        self.vm = vm
        let count = Int.random(in: 2...5)
        _fishCount = State(initialValue: count)
        _rotations = State(initialValue: Array(repeating: 0.0, count: count))
        _positions = State(initialValue: Self.generatePositions(count: count))
        _sizes = State(initialValue: Self.generateSizes(count: count))
        _scales = State(initialValue: Array(repeating: 1.0, count: count))
        _isAlive = State(initialValue: Array(repeating: true, count: count))
        _fishColors = State(initialValue: (0..<count).map { _ in Int.random(in: 0..<5) })
        _fishTypes = State(initialValue: (0..<count).map { _ in FishShape.allCases.randomElement()! })
        _rotationSpeeds = State(initialValue: Self.generateRotationSpeeds(count: count))
    }
    
    static func generatePositions(count: Int) -> [(CGFloat, CGFloat)] {
        var positions: [(CGFloat, CGFloat)] = []
        for _ in 0..<count {
            let x = CGFloat.random(in: -150...150)
            let y = CGFloat.random(in: -150...150)
            positions.append((x, y))
        }
        return positions
    }
    
    static func generateSizes(count: Int) -> [CGFloat] {
        var sizes: [CGFloat] = []
        for _ in 0..<count {
            let size = CGFloat.random(in: 40...100)
            sizes.append(size)
        }
        return sizes
    }
    
    static func generateRotationSpeeds(count: Int) -> [Double] {
        var speeds: [Double] = []
        for _ in 0..<count {
            let speed = Double.random(in: 1.0...4.0)
            speeds.append(speed)
        }
        return speeds
    }
    
    func checkCollisions() {
        for i in 0..<fishCount {
            guard isAlive[i] else { continue }
            for j in 0..<fishCount {
                guard i != j && isAlive[j] else { continue }
                
                // Calculate distance between fish centers
                let dx = positions[i].0 - positions[j].0
                let dy = positions[i].1 - positions[j].1
                let distance = sqrt(dx * dx + dy * dy)
                
                // If fish are close enough and one is bigger
                if distance < (sizes[i] + sizes[j]) / 3 {
                    if sizes[i] > sizes[j] * 1.2 {
                        // Big fish eats small fish
                        eatFish(predator: i, prey: j)
                    } else if sizes[j] > sizes[i] * 1.2 {
                        // Small fish gets eaten
                        eatFish(predator: j, prey: i)
                    }
                }
            }
        }
    }
    
    func cleanupDeadFish() {
        // Remove dead fish that have been dead for more than 2 seconds
        let now = Date()
        deadFish.removeAll { now.timeIntervalSince($0.createdAt) > 2.0 }
    }
    
    func cleanupEffects() {
        // Remove bubbles that are older than 1 second
        let now = Date()
        bubbles.removeAll { now.timeIntervalSince($0.createdAt) > 1.0 }
        // Remove tap effects that are older than 0.3 seconds
        tapEffects.removeAll { now.timeIntervalSince($0.createdAt) > 0.3 }
    }
    
    func eatFish(predator: Int, prey: Int) {
        // Create a dead fish at the prey's position
        let deadFishPosition = CGPoint(x: positions[prey].0, y: positions[prey].1)
        let deadFishRotation = rotations[prey]
        withAnimation(.easeInOut(duration: 0.3)) {
            isAlive[prey] = false
            scales[prey] = 0.1
            // Predator grows slightly
            sizes[predator] *= 1.1
            scales[predator] = 1.2
            // Change predator's color
            fishColors[predator] = (fishColors[predator] + 1) % 5
            
            // Add dead fish to our array with current timestamp
            deadFish.append((
                type: fishTypes[prey],
                position: deadFishPosition,
                rotation: deadFishRotation,
                size: sizes[prey],
                createdAt: Date()
            ))
        }
        
        // Reset predator scale after growth animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.2)) {
                scales[predator] = 1.0
            }
        }
    }
    
    func addNewFish() {
        // Count how many fish are still alive
        let aliveFishCount = isAlive.filter { $0 }.count
        
        // Only add new fish if we have less than minimum (2)
        if aliveFishCount < 2 {
            let newFishNeeded = 2 - aliveFishCount
            
            // Extend arrays to accommodate new fish
            withAnimation(.easeInOut(duration: 0.5)) {
                for _ in 0..<newFishNeeded {
                    fishCount += 1
                    rotations.append(0.0)
                    positions.append((CGFloat.random(in: -150...150), CGFloat.random(in: -150...150)))
                    sizes.append(CGFloat.random(in: 40...100))
                    rotationSpeeds.append(Double.random(in: 1.0...4.0))
                    isAlive.append(true)
                    scales.append(1.0)
                    fishColors.append(Int.random(in: 0..<5))
                    fishTypes.append(FishShape.allCases.randomElement()!)
                    
                    // Start rotation for new fish
                    let newIndex = fishCount - 1
                    withAnimation(
                        .linear(duration: rotationSpeeds[newIndex])
                        .repeatForever(autoreverses: false)
                    ) {
                        rotations[newIndex] = newIndex % 2 == 0 ? 360 : -360
                    }
                }
            }
        }
    }
    
    func updateFishPositions() {
        for i in 0..<fishCount {
            guard isAlive[i] else { continue }
            
            // Find nearest smaller fish
            var nearestPrey: Int? = nil
            var minDistance = CGFloat.infinity
            
            for j in 0..<fishCount {
                guard i != j && isAlive[j] && sizes[i] > sizes[j] * 1.2 else { continue }
                
                let dx = positions[j].0 - positions[i].0
                let dy = positions[j].1 - positions[i].1
                let distance = sqrt(dx * dx + dy * dy)
                
                if distance < minDistance {
                    minDistance = distance
                    nearestPrey = j
                }
            }
            
            // Chase behavior
            if let prey = nearestPrey {
                // Calculate direction to prey
                let dx = positions[prey].0 - positions[i].0
                let dy = positions[prey].1 - positions[i].1
                let distance = sqrt(dx * dx + dy * dy)
                
                // Normalize direction and apply speed based on size
                let speed = (150 - sizes[i]) / 50 // Much faster base speed
                let moveX = (dx / distance) * speed * 6 // Significantly increased multiplier
                let moveY = (dy / distance) * speed * 6
                
                // Update position with smooth animation
                withAnimation(.linear(duration: 0.1)) {
                    positions[i].0 += moveX
                    positions[i].1 += moveY
                    
                    // Keep fish within bounds
                    positions[i].0 = max(-150, min(150, positions[i].0))
                    positions[i].1 = max(-150, min(150, positions[i].1))
                }
                
                // Update rotation to face prey
                let angle = atan2(dy, dx)
                withAnimation(.linear(duration: 0.1)) {
                    rotations[i] = (angle * (180 / .pi)) + 180
                }
            } else {
                // Random movement for fish with no prey
                let randomAngle = Double.random(in: 0...(2 * .pi))
                let speed = (150 - sizes[i]) / 50 // Use same speed formula as chase behavior
                let moveX = cos(randomAngle) * speed * 6
                let moveY = sin(randomAngle) * speed * 6

                withAnimation(.linear(duration: 0.1)) {
                    positions[i].0 += moveX
                    positions[i].1 += moveY
                    
                    // Keep fish within bounds
                    positions[i].0 = max(-150, min(150, positions[i].0))
                    positions[i].1 = max(-150, min(150, positions[i].1))
                    
                    // Update rotation to match movement direction
                    rotations[i] = (randomAngle * (180 / .pi)) + 180 // Added 180 degrees to make fish face forward
                }
            }
        }
    }
    
    func spawnSmallFish() {
        // Add 2-3 new small fish
        let newFishCount = Int.random(in: 2...3)
        
        withAnimation(.easeInOut(duration: 0.5)) {
            for _ in 0..<newFishCount {
                fishCount += 1
                rotations.append(0.0)
                // Spawn small fish (30-50 size range)
                sizes.append(CGFloat.random(in: 30...50))
                positions.append((CGFloat.random(in: -150...150), CGFloat.random(in: -150...150)))
                rotationSpeeds.append(Double.random(in: 1.0...4.0))
                isAlive.append(true)
                scales.append(0.0) // Start small for pop-in animation
                fishColors.append(Int.random(in: 0..<5))
                fishTypes.append(FishShape.allCases.randomElement()!)
                
                // Start rotation for new fish
                let newIndex = fishCount - 1
                withAnimation(
                    .linear(duration: rotationSpeeds[newIndex])
                    .repeatForever(autoreverses: false)
                ) {
                    rotations[newIndex] = newIndex % 2 == 0 ? 360 : -360
                }
                
                // Animate scale
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                    scales[newIndex] = 1.0
                }
            }
        }
    }
    
    func updateFishGrowth() {
        for i in 0..<fishCount {
            guard isAlive[i] else { continue }
            
            // Grow the fish
            sizes[i] += growthRate
            
            // Check if fish should pop
            if sizes[i] >= maxFishSize {
                popFish(at: i)
            }
        }
    }
    
    func popFish(at index: Int) {
        let position = CGPoint(x: positions[index].0, y: positions[index].1)
        
        // Add more bubble effects
        for _ in 0...8 {
            bubbles.append((
                position: CGPoint(
                    x: position.x + CGFloat.random(in: -30...30),
                    y: position.y + CGFloat.random(in: -30...30)
                ),
                scale: CGFloat.random(in: 0.8...2.0),
                createdAt: Date()
            ))
        }
        
        // Initial pop expansion
        withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
            scales[index] = 2.0
        }
        
        // Quick rotation
        withAnimation(.easeInOut(duration: 0.2)) {
            rotations[index] += 360
        }
        
        // Fade out and shrink
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeOut(duration: 0.2)) {
                isAlive[index] = false
                scales[index] = 0
            }
        }
    }
    
    func addTapEffect(at position: CGPoint) {
        tapEffects.append((position: position, createdAt: Date()))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.blue.opacity(0.1)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    ZStack {
                        // Bubble effects
                        ForEach(bubbles.indices, id: \.self) { index in
                            Circle()
                                .fill(Color.white.opacity(0.6))
                                .frame(width: 10, height: 10)
                                .scaleEffect(bubbles[index].scale)
                                .position(
                                    x: bubbles[index].position.x + geometry.size.width/2,
                                    y: bubbles[index].position.y + geometry.size.height/2
                                )
                                .transition(.scale)
                        }
                        
                        // Dead fish
                        ForEach(deadFish.indices, id: \.self) { index in
                            CustomFishView(fishType: deadFish[index].type, color: .white, isDead: true)
                                .frame(width: deadFish[index].size * 0.8, height: deadFish[index].size * 0.8)
                                .rotationEffect(.degrees(deadFish[index].rotation))
                                .position(
                                    x: deadFish[index].position.x + geometry.size.width/2,
                                    y: deadFish[index].position.y + geometry.size.height/2
                                )
                                .modifier(SinkingModifier())
                        }
                        
                        // Live fish
                        ForEach(0..<fishCount, id: \.self) { index in
                            if isAlive[index] {
                                CustomFishView(fishType: fishTypes[index], color: colors[fishColors[index]], isDead: false)
                                    .frame(width: sizes[index], height: sizes[index])
                                    .rotationEffect(.degrees(rotations[index]))
                                    .scaleEffect(scales[index])
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                                    .position(x: geometry.size.width/2 + positions[index].0,
                                            y: geometry.size.height/2 + positions[index].1)
                                    .onTapGesture { location in
                                        addTapEffect(at: CGPoint(x: geometry.size.width/2 + positions[index].0,
                                                              y: geometry.size.height/2 + positions[index].1))
                                        popFish(at: index)
                                    }
                                    .contentShape(Circle())
                            }
                        }

                        // Tap effects
                        ForEach(tapEffects.indices, id: \.self) { index in
                            Circle()
                                .stroke(Color.red, lineWidth: 3)
                                .frame(width: 50, height: 50)
                                .position(tapEffects[index].position)
                                .opacity(1 - min(1.0, Date().timeIntervalSince(tapEffects[index].createdAt) / 0.3))
                                .scaleEffect(1 + min(2.0, Date().timeIntervalSince(tapEffects[index].createdAt) * 3))
                                .animation(.easeOut(duration: 0.3), value: Date().timeIntervalSince(tapEffects[index].createdAt))
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onEnded { value in
                                addTapEffect(at: value.location)
                            }
                    )
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Button(action: {
                            spawnSmallFish()
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Add Fish")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 12)
                            .background(
                                Capsule()
                                    .fill(Color.blue.opacity(0.3))
                                    .shadow(color: .black.opacity(0.2), radius: 5)
                            )
                        }
                        .shadow(radius: 5)
                    }
                    .padding(.bottom, 40)
                }
            }
        }
        .onReceive(collisionTimer) { _ in
            checkCollisions()
            updateFishPositions()
        }
        .onReceive(cleanupTimer) { _ in
            cleanupDeadFish()
            cleanupEffects()
        }
        .onReceive(growthTimer) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                updateFishGrowth()
            }
        }
        .onAppear {
            for index in 0..<fishCount {
                withAnimation(
                    .linear(duration: rotationSpeeds[index])
                    .repeatForever(autoreverses: false)
                ) {
                    rotations[index] = index % 2 == 0 ? 360 : -360
                }
            }
        }
    }
}

struct SinkingModifier: ViewModifier {
    @State private var offset: CGFloat = 0
    @State private var opacity: Double = 1.0
    
    func body(content: Content) -> some View {
        content
            .offset(y: offset)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeInOut(duration: 2.0)) {
                    offset = 100 // Sink down
                    opacity = 0 // Fade out
                }
            }
    }
}

struct MainView: View {
    var body: some View {
        Text("Main Content")
            .font(.largeTitle)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    ContentView()
}
