local Library = {}

function Library:CreateWindow(title)
    local window = {}
    window.title = title
    window.sections = {}

    function window:NewSection(sectionTitle)
        local section = {}
        section.title = sectionTitle
        section.elements = {}

        function section:CreateButton(text, callback)
            local button = { type = "Button", text = text, callback = callback }
            table.insert(section.elements, button)
            callback()  -- Ejecutar la función de callback para probar
        end

        function section:CreateTextbox(placeholder, callback)
            local textbox = { type = "Textbox", placeholder = placeholder, callback = callback }
            table.insert(section.elements, textbox)
            callback(placeholder)  -- Ejecutar la función de callback para probar
        end

        function section:CreateToggle(text, callback)
            local toggle = { type = "Toggle", text = text, callback = callback }
            table.insert(section.elements, toggle)
            callback(true)  -- Ejecutar la función de callback para probar
        end

        function section:CreateDropdown(text, items, default, callback)
            local dropdown = { type = "Dropdown", text = text, items = items, default = default, callback = callback }
            table.insert(section.elements, dropdown)
            callback(items[default])  -- Ejecutar la función de callback para probar
        end

        function section:CreateSlider(text, min, max, default, isInt, callback)
            local slider = { type = "Slider", text = text, min = min, max = max, default = default, isInt = isInt, callback = callback }
            table.insert(section.elements, slider)
            callback(default)  -- Ejecutar la función de callback para probar
        end

        function section:CreateColorPicker(text, default, callback)
            local colorpicker = { type = "ColorPicker", text = text, default = default, callback = callback }
            table.insert(section.elements, colorpicker)
            callback(default)  -- Ejecutar la función de callback para probar
        end

        table.insert(window.sections, section)
        return section
    end

    return window
end

return Library
