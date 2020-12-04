import PlaygroundSupport
import SwiftUI

struct ContentView {
    @State var keyword = ""
    @State var fontSize = 60.0
    @State var fontWeight = Font.Weight.regular
    @State var renderingMode = Image.TemplateRenderingMode.template
    @State var textFormatIsVisible = false

    var columns: [GridItem] {
        [self.fontSize * 2].lazy
            .map { max($0, 120) }
            .map { CGFloat($0) }
            .map { .init(.adaptive(minimum: $0)) }
    }

    var symbols: [String] {
        Symbols.symbols
            .filter { self.keyword.isEmpty ? true : $0.contains(self.keyword) }
    }

    func showTextFormat() {
        self.textFormatIsVisible = true
    }
}

extension ContentView: View {
    var body: some View {
        VStack {
            HStack {
                SearchBar(text: self.$keyword)
                Button(action: self.showTextFormat) {
                    Image(systemName: "textformat")
                }
                .padding(.trailing)
                .popover(isPresented: self.$textFormatIsVisible) {
                    TextFormatView(
                        fontSize: self.$fontSize,
                        fontWeight: self.$fontWeight,
                        renderingMode: self.$renderingMode
                    )
                    .padding()
                }
            }
            ScrollView {
                LazyVGrid(columns: self.columns) {
                    ForEach(self.symbols, id: \.self) { name in
                        SymbolView(
                            name: name,
                            fontSize: self.$fontSize,
                            fontWeight: self.$fontWeight,
                            renderingMode: self.$renderingMode
                        )
                        .padding()
                    }
                    .id(UUID())
                }
            }
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
