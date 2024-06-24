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
            -- Código para crear el botón
        end

        function section:CreateTextbox(placeholder, callback)
            local textbox = { type = "Textbox", placeholder = placeholder, callback = callback }
            table.insert(section.elements, textbox)
            -- Código para crear el cuadro de texto
        end

        function section:CreateToggle(text, callback)
            local toggle = { type = "Toggle", text = text, callback = callback }
            table.insert(section.elements, toggle)
            -- Código para crear el alternador
        end

        function section:CreateDropdown(text, items, default, callback)
            local dropdown = { type = "Dropdown", text = text, items = items, default = default, callback = callback }
            table.insert(section.elements, dropdown)
            -- Código para crear el menú desplegable
        end

        function section:CreateSlider(text, min, max, default, isInt, callback)
            local slider = { type = "Slider", text = text, min = min, max = max, default = default, isInt = isInt, callback = callback }
            table.insert(section.elements, slider)
            -- Código para crear el deslizador
        end

        function section:CreateColorPicker(text, default, callback)
            local colorpicker = { type = "ColorPicker", text = text, default = default, callback = callback }
            table.insert(section.elements, colorpicker)
            -- Código para crear el selector de color
        end

        table.insert(window.sections, section)
        return section
    end

    return window
end