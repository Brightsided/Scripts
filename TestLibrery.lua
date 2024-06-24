local Library = {}

function Library:CreateWindow(title)
    local window = {}
    window.title = title
    window.sections = {}
    print("Window created with title: " .. title)

    function window:NewSection(sectionTitle)
        local section = {}
        section.title = sectionTitle
        section.elements = {}
        print("Section created with title: " .. sectionTitle)

        function section:CreateButton(text, callback)
            local button = { type = "Button", text = text, callback = callback }
            table.insert(section.elements, button)
            print("Button created with text: " .. text)
            -- Simulate button press for testing
            callback()
        end

        function section:CreateTextbox(placeholder, callback)
            local textbox = { type = "Textbox", placeholder = placeholder, callback = callback }
            table.insert(section.elements, textbox)
            print("Textbox created with placeholder: " .. placeholder)
            -- Simulate textbox input for testing
            callback(placeholder)
        end

        function section:CreateToggle(text, callback)
            local toggle = { type = "Toggle", text = text, callback = callback }
            table.insert(section.elements, toggle)
            print("Toggle created with text: " .. text)
            -- Simulate toggle for testing
            callback(true)
        end

        function section:CreateDropdown(text, items, default, callback)
            local dropdown = { type = "Dropdown", text = text, items = items, default = default, callback = callback }
            table.insert(section.elements, dropdown)
            print("Dropdown created with text: " .. text)
            -- Simulate dropdown selection for testing
            callback(items[default])
        end

        function section:CreateSlider(text, min, max, default, isInt, callback)
            local slider = { type = "Slider", text = text, min = min, max = max, default = default, isInt = isInt, callback = callback }
            table.insert(section.elements, slider)
            print("Slider created with text: " .. text)
            -- Simulate slider adjustment for testing
            callback(default)
        end

        function section:CreateColorPicker(text, default, callback)
            local colorpicker = { type = "ColorPicker", text = text, default = default, callback = callback }
            table.insert(section.elements, colorpicker)
            print("ColorPicker created with text: " .. text)
            -- Simulate color picker for testing
            callback(default)
        end

        table.insert(window.sections, section)
        return section
    end

    return window
end

return Library
