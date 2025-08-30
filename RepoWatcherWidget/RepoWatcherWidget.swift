//
//  RepoWatcherWidget.swift
//  RepoWatcherWidget
//
//  Created by Lahiru Amarasooriya on 2025-08-30.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> RepoEntry {
        RepoEntry(date: Date(), repo: .placeholder)
    }

    func getSnapshot(in context: Context, completion: @escaping (RepoEntry) -> ()) {
        let entry = RepoEntry(date: Date(), repo: .placeholder)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [RepoEntry] = []

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct RepoEntry: TimelineEntry {
    let date: Date
    let repo: Repository
}

struct RepoWatcherWidgetEntryView : View {
    var entry: Provider.Entry
    
    let dateFormatter = ISO8601DateFormatter()
    
    var daysSinceLastActivity: Int {
        calculateDaysSinceLastActivity(from: entry.repo.pushedAt)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Circle()
                        .frame(width: 50, height: 50)
                    
                    Text(entry.repo.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                    
                    
                }
                .padding(.bottom, 6)
                
                HStack {
                    
                    StatLabel(value: entry.repo.watchers, systemImageName: "star.fill")
                    StatLabel(value: entry.repo.forks, systemImageName: "tuningfork")
                    StatLabel(value: entry.repo.openIssues, systemImageName: "exclamationmark.triangle.fill")
                }
            }
            
            Spacer()
            
            VStack {
                Text("\(calculateDaysSinceLastActivity(from: entry.repo.pushedAt))")
                    .bold()
                    .font(.system(size: 70))
                    .frame(width: 90)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .foregroundStyle(daysSinceLastActivity > 50 ? .pink : .green)
                
                Text("days ago")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    func calculateDaysSinceLastActivity(from dateString: String) -> Int {
        
        let lastActivityDate = dateFormatter.date(from: dateString) ?? .now
        let daysSinceLastActivity = Calendar.current.dateComponents([.day], from: lastActivityDate, to: .now).day ?? 0
        
        return daysSinceLastActivity
    }
}

struct RepoWatcherWidget: Widget {
    let kind: String = "RepoWatcherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
                RepoWatcherWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    RepoWatcherWidget()
} timeline: {
    RepoEntry(date: .now, repo: .placeholder)
    RepoEntry(date: .now, repo: .placeholder)
}

fileprivate struct StatLabel: View {
    
    let value: Int
    let systemImageName: String
    
    var body: some View {
        Label {
            Text("\(value)")
                .font(.footnote)
        } icon: {
            Image(systemName: systemImageName)
                .foregroundColor(.green)
        }
        .fontWeight(.medium)
    }
}
