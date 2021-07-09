local snap = require('snap')

local vimp = require('vimp')

vimp.nnoremap('<C-f>', function()
    snap.run {
        prompt = 'Git Files',
        producer = snap.get('consumer.fzy')(snap.get('producer.git.file')),
        select = snap.get('select.file').select,
        multiselect = snap.get('select.file').multiselect,
        views = { snap.get('preview.file') }
    }
end)

--[[
vimp.nnoremap('<C-S-f>', function()
    snap.run {
        prompt = 'Files',
        producer = snap.get('consumer.fzy')(snap.get('producer.ripgrep.file')),
        select = snap.get('select.file').select,
        multiselect = snap.get('select.file').multiselect,
        view = { snap.get('preview.file') }
    }
end)
--]]

--[[
vimp.nnoremap('<C-s>', function()
    snap.run {
        prompt = 'Rg',
        producer = snap.get('consumer.limit')(1000, snap.get('producer.ripgrep.vimgrep')),
        select = snap.get('select.vimgrep').select,
        multiselect = snap.get('select.vimgrep').multiselect,
        views = { snap.get('preview.vimgrep') }
    }
end)
--]]

vimp.nnoremap('<C-b>', function()
    snap.run {
        prompt = 'Buffers',
        producer = snap.get('consumer.fzy')(snap.get('producer.vim.buffer')),
        select = snap.get('select.file').select,
        multiselect = snap.get('select.file').multiselect,
        views = { snap.get('preview.file') }
    }
end)
