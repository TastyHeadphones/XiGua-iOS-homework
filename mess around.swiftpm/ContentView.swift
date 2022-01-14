import SwiftUI


struct ContentView: View {
    
    
    @State var lights = Lights.sharedInstance.lights
    @State var trueCount = Lights.sharedInstance.trueCount
    @State var level = 1
    @State var operateTimes = 0
    @State var shouldShowSucceed = false
    @State var timerDisplayed = 0
    
    @State var succeedView = SucceedView()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        
        
        
        VStack {
            
            HStack{
                Label("当前是第 \(level) 关", systemImage: "heart.fill")
                    .font(.system(size: 50))
                
                
            }.sheet(isPresented: $shouldShowSucceed) {
                succeedView
            }
            HStack{
                Text("当前用时 \(timerDisplayed) s")
                    .font(.system(size: 50))
                    .onReceive(timer) { _ in
                        timerDisplayed += 1
                    }
            }
            HStack{
                Text("当前操作 \(operateTimes) 次")
                    .font(.system(size: 50))
            }
            
            ForEach (0..<lights.count){
                row in
                HStack{
                    ForEach (0..<lights[0].count){
                        col in
                        HStack{
                            
                            
                            Circle()
                                .foregroundColor(lights[row][col].status ? lights[row][col].color : .gray)
                                .frame(width: 100, height: 100, alignment: .center)
                                .rotation3DEffect(lights[row][col].status ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                                .animation(.default)
                                .onTapGesture {
                                    
                                    
                                    
                                    for y in -1...1{
                                        for x in -1...1{
                                            let newCol = x + col
                                            let newRow = y + row
                                            
                                            if (0 <= newCol && newCol < lights[0].count && 0 <= newRow && newRow < lights.count){
                                                if (lights[newRow][newCol].status){
                                                    operateTimes += 1
                                                    trueCount -= 1
                                                    lights[newRow][newCol].status.toggle()
                                                    }
                                                
                                            }
                                        }
                                    }
                                        
                                        
                                        
                                        if (trueCount <= 0){
                                            Lights.sharedInstance.newLights()
                                            
                                            Lights.sharedInstance.newLights()
                                            
                                            lights = Lights.sharedInstance.lights
                                            
                                            trueCount = Lights.sharedInstance.trueCount
                                            succeedView.opTimes = operateTimes
                                            succeedView.interval = timerDisplayed
                                            shouldShowSucceed = true
                                            level += 1
                                            timerDisplayed = 0
                                            operateTimes = 0
                                        }
                                    }
                                    
                                }
                        }
                    }
                    
                    
                }
            }
            
            
        }
    }




// MARK: - 烟花特效
struct FireworkParticlesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 20 ... 200)
    var direction = Double.random(in: -Double.pi ...  Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}

struct ParticlesModifier: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    let duration = 5.0
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<80, id: \.self) { index in
                content
                    .hueRotation(Angle(degrees: time * 80))
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity(((duration-time) / duration))
            }
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration)) {
                self.time = duration
                self.scale = 1.0
            }
        }
    }
}

struct SucceedView: View {
    var interval:Int = 0
    var opTimes:Int = 0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        
        ZStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 50, height: 50)
                .modifier(ParticlesModifier())
                .offset(x: -100, y : -50)
            
            Circle()
                .fill(Color.red)
                .frame(width: 50, height: 50)
                .modifier(ParticlesModifier())
                .offset(x: 60, y : 70)
            
            
        }
        
        VStack {
                        HStack{
                            Label("恭喜过关", systemImage: "heart.fill")
                                .font(.system(size: 50))
            
                        }
            HStack{
                Text("用时 \(interval) s")
                    .font(.system(size: 50))
            }.padding()
            HStack{
                Text("操作 \(opTimes) 次")
                    .font(.system(size: 50))
            }.padding()
            HStack{
                Button(
                    "下一关",
                    action: { self.presentationMode.wrappedValue.dismiss() }
                ).font(.system(size: 50))
            }.padding()
            
            
            
        }
    }
    
    
}
