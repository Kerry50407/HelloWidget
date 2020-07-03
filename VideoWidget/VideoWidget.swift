//
//  VideoWidget.swift
//  VideoWidget
//
//  Created by Kerry Dong on 2020/7/2.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    public typealias Entry = SimpleEntry

    public func snapshot(with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        if context.isPreview {
            
        }
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    public func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct VideoWidgetEntryView : View {
    @Environment(\.widgetFamily)
    var family: WidgetFamily
    
    var entry: Provider.Entry

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            Text(entry.date, style: .time)
        case .systemMedium:
            Text(entry.date, style: .time)
        case .systemLarge:
            HStack {
                Text(entry.date, style: .time)
                Image("colorful").scaledToFit()
            }
        default:
            HStack {
                Text(entry.date, style: .time)
                Image("colorful").scaledToFit()
            }
        }
    }
}


struct MediaWidget: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        VideoWidget()
        MusicWidget()
    }
}

@main
struct VideoWidget: Widget {
    private let kind: String = "VideoWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), placeholder: PlaceholderView()) { entry in
            VideoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct MusicWidget: Widget {
    private let kind: String = "MusicWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), placeholder: PlaceholderView()) { entry in
            VideoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Hi Hi Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
