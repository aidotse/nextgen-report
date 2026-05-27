function Code(el)
  -- 1. For the PDF: Bypass translation and inject raw Typst wrapper
  if FORMAT == "typst" then
    return pandoc.RawInline('typst', '#InlineCode[`' .. el.text .. '`]')
  end
  
  -- 2. For the Web: Inject a hard-coded class so we can beat Bootstrap's CSS
  if FORMAT == "html" then
    el.classes:insert('inline-code')
    return el
  end
end

-- Intercept Spans (inline text)
function Span(el)
  -- Transform the orange badge for Typst
  if el.classes:includes("orange-badge") and FORMAT == "typst" then
    return pandoc.RawInline('typst', '#highlight(fill: rgb("#FFE0B2"))[#text(fill: rgb("#E65100"), weight: "bold")[' .. pandoc.utils.stringify(el) .. ']]')
  end
  
  -- Transform the gray subtext for Typst
  if el.classes:includes("subtext") and FORMAT == "typst" then
    return pandoc.RawInline('typst', '#text(fill: rgb("#777777"), size: 0.9em)[' .. pandoc.utils.stringify(el) .. ']')
  end

  if el.classes:includes("quiz-tag") and FORMAT == "typst" then
    return pandoc.RawInline('typst', '#QuizTag[' .. pandoc.utils.stringify(el) .. ']')
  end
  if el.classes:includes("label-orange") and FORMAT == "typst" then
    return pandoc.RawInline('typst', '#text(fill: rgb("#E65100"), font: "Roboto Mono", weight: "bold")[' .. pandoc.utils.stringify(el) .. ']')
  end
  if el.classes:includes("label-blue") and FORMAT == "typst" then
    return pandoc.RawInline('typst', '#text(fill: rgb("#2196F3"), font: "Roboto Mono", weight: "bold")[' .. pandoc.utils.stringify(el) .. ']')
  end
  if el.classes:includes("label-dark") and FORMAT == "typst" then
    return pandoc.RawInline('typst', '#text(fill: rgb("#333333"), font: "Roboto Mono", weight: "bold")[' .. pandoc.utils.stringify(el) .. ']')
  end
end

-- Intercept Divs (our card blocks)
function Div(el)
  if el.classes:includes("custom-card") and FORMAT == "typst" then
    local theme = "anchor"
    if el.classes:includes("positive-theme") then theme = "positive" end
    if el.classes:includes("negative-theme") then theme = "negative" end
    
    -- 1. Compile the inner markdown content into a Typst string first
    local inner_typst = pandoc.write(pandoc.Pandoc(el.content), 'typst')
    
    -- 2. Wrap it entirely in a single, bulletproof RawBlock
    local full_typst_string = '#CustomCard("' .. theme .. '")[\n' .. inner_typst .. '\n]'
    
    return pandoc.RawBlock('typst', full_typst_string)
  end

    if el.classes:includes("quiz-card") and FORMAT == "typst" then
    local inner_typst = pandoc.write(pandoc.Pandoc(el.content), 'typst')
    return pandoc.RawBlock('typst', '#QuizCard[\n' .. inner_typst .. '\n]')
  end
  
  if el.classes:includes("mcq-option") and FORMAT == "typst" then
    local is_correct = el.classes:includes("correct") and "true" or "false"
    local inner_typst = pandoc.write(pandoc.Pandoc(el.content), 'typst')
    return pandoc.RawBlock('typst', '#McqOption(correct: ' .. is_correct .. ')[\n' .. inner_typst .. '\n]')
  end

  if el.classes:includes("prompt-box") and FORMAT == "typst" then
    local inner_typst = pandoc.write(pandoc.Pandoc(el.content), 'typst')
    return pandoc.RawBlock('typst', '#PromptBox[\n' .. inner_typst .. '\n]')
  end

  if el.classes:includes("prompt-box") and FORMAT == "typst" then
    local inner_typst = pandoc.write(pandoc.Pandoc(el.content), 'typst')
    return pandoc.RawBlock('typst', '#PromptBox[\n' .. inner_typst .. '\n]')
  end

  -- NEW: Intercept Algorithm Boxes
  if el.classes:includes("algorithm-box") and FORMAT == "typst" then
    local inner_typst = pandoc.write(pandoc.Pandoc(el.content), 'typst')
    return pandoc.RawBlock('typst', '#algorithm-box[\n' .. inner_typst .. '\n]')
  end
end

