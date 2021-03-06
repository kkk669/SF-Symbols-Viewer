import SwiftUI

public struct TextFormatView {
    @Binding var fontSize: Double
    @Binding var fontWeight: Font.Weight
    @Binding var renderingMode: Image.TemplateRenderingMode
    @Binding var color: Color

    public init(
        fontSize: Binding<Double>,
        fontWeight: Binding<Font.Weight>,
        renderingMode: Binding<Image.TemplateRenderingMode>,
        color: Binding<Color>
    ) {
        self._fontSize = fontSize
        self._fontWeight = fontWeight
        self._renderingMode = renderingMode
        self._color = color
    }
}

extension TextFormatView: View {
    public var body: some View {
        VStack {
            Picker("Font Weights", selection: self.$fontWeight) {
                ForEach(Font.Weight.allCases, id: \.self) { weight in
                    Image(systemName: "textformat")
                        .font(.system(size: 10, weight: weight))
                        .tag(weight)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            HStack {
                Image(systemName: "textformat.size.smaller")
                    .font(.system(size: 20))
                Slider(value: self.$fontSize, in: 0...120)
                Image(systemName: "textformat.size.larger")
                    .font(.system(size: 20))
            }
            .padding(.vertical)
            HStack {
                Picker("Rendering Mode", selection: self.$renderingMode) {
                    ForEach(Image.TemplateRenderingMode.allCases, id: \.self) { mode in
                        Text(mode.description)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                ColorPicker(selection: self.$color) {
                    EmptyView()
                }
            }
        }
    }
}
