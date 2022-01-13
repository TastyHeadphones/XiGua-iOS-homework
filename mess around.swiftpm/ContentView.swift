import SwiftUI


struct ContentView: View {
    
    
    @State var lights = Lights.sharedInstance.lights
    @State var trueCount = Lights.sharedInstance.trueCount
    @State var level = 1
    
    
    var body: some View {
        
        VStack {
            HStack{
                Label("当前是第 \(level) 关", systemImage: "heart.fill")
                    .font(.system(size: 60))
            }
            ForEach (0..<lights.count){
                row in
                HStack{
                    ForEach (0..<lights[0].count){
                        col in
                        HStack{
                            
                            
                            Circle()
                                .foregroundColor(lights[row][col].status ? lights[row][col].color : .gray)
                                .frame(width: 120, height: 120, alignment: .center)
                                .rotation3DEffect(lights[row][col].status ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                                .animation(.default)
                                .onTapGesture {
                                    if (lights[row][col].status){
                                        lights[row][col].status.toggle()
                                        trueCount -= 1
                                        
                                        if (trueCount <= 0){
                                            Lights.sharedInstance.newLights()
                                            print("newGame")
                                            Lights.sharedInstance.newLights()
                                            
                                            lights = Lights.sharedInstance.lights
                                            
                                            trueCount = Lights.sharedInstance.trueCount
                                            
                                    level += 1
                                        }
                                    }
                                    
                                }
                        }
                        
                    }
                }
                
                
            }
        }
    }
}
