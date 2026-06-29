-- build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'
local telescope_fzf_build_hook = function(ev)

    local name, kind = ev.data.spec.name, ev.data.kind

    -- Run cmake Script after plugin has been installed or updated
    if name == 'telescope-fzf-native' and (kind == 'install' or kind == 'update') then
        -- build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'
        vim.system({'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'}, {cwd = ev.data.path})
    end
end

vim.api.nvim_create_autocmd('PackChanged', { callback = telescope_fzf_build_hook})

vim.pack.add({
    -- library used by other plugins
    { src = 'https://github.com/nvim-lua/plenary.nvim'},
    { src = 'https://github.com/nvim-tree/nvim-web-devicons'},
    { src = 'https://github.com/nvim-lua/plenary.nvim'},
    { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
})

