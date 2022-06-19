//
//  CountdownView.swift
//  Pomodoro
//
//  Created by Leptos on 5/14/22.
//

import SwiftUI

struct CountdownView: View {
    let taskTitle: String
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    @ObservedObject var countdown: CountdownViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            
            Text(taskTitle)
                .font(.title)
                .underline()
            
            TimelineView(.animation) { timelineContext in
                let observerDate = timelineContext.date
                let timeIntervalRemaining = countdown.timeIntervalRemaining(for: observerDate)
                
                ZStack {
                    let lineWidth: CGFloat = 24
                    Circle()
                        .stroke(Color.themeTertiary, style: .init(lineWidth: lineWidth))
                    
                    Circle()
                        .rotation(.degrees(-90))
                        .trim(from: 0, to: timeIntervalRemaining/countdown.totalDuration)
                        .stroke(Color.timerForeground, style: .init(lineWidth: lineWidth, lineCap: .round))
                        .overlay {
                            Text(observerDate.addingTimeInterval(max(0, timeIntervalRemaining)), style: .timer)
                                .font(.largeTitle)
                                .opacity(countdown.isRunning ? 1 : 0.62)
                                .animation(.linear, value: countdown.isRunning)
                        }
                }
            }
            .frame(width: 284, height: 284)
            .padding()
            
            Button {
                if countdown.isRunning {
                    countdown.pause()
                } else {
                    countdown.resume()
                }
            } label: {
                Text(countdown.isRunning ? "Pause" : "Resume")
                    .font(.callout.bold())
                    .foregroundColor(.timerForeground)
                    .frame(width: 152, height: 54, alignment: .center)
                    .background {
                        RoundedRectangle(cornerRadius: 38, style: .continuous)
                            .strokeBorder(Color.timerForeground, lineWidth: 4)
                    }
            }
            
            Button {
                dismiss()
            } label: {
                Text("Done!")
                    .font(.callout.bold())
                    .foregroundColor(.timerForeground)
                    .frame(width: 152, height: 54, alignment: .center)
                    .background {
                        RoundedRectangle(cornerRadius: 38, style: .continuous)
                            .strokeBorder(Color.timerForeground, lineWidth: 4)
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            BubbleEffect()
                .blur(radius: 25.0)
        }
        .navigationBarHidden(true)
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(taskTitle: "Coding", countdown: .init(duration: 120))
    }
}
