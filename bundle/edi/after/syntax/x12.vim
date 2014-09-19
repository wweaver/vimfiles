syn cluster vimEmbeddedScript contains=vimFoldSection

syn region vimFoldSection
    \ start="^ST"
    \ end="^SE"
    \ transparent fold
    \ keepend extend
