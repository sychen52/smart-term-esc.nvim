_G.termesc = {}

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.termesc.smart_esc = function(term_pid)
    local function find_process(pid)
        local p = vim.api.nvim_get_proc(pid)
        if _G.termesc.except[p.name] then
            return true
        end
        for _,v in ipairs(vim.api.nvim_get_proc_children(pid)) do
            if find_process(v) then
                return true
            end
        end
        return false
    end
    if find_process(term_pid) then
        return t(_G.termesc.key)
    else
        return t'<C-\\><C-n>'
    end
end

local set = function(table)
    local ret = {}
    for _, v in ipairs(table) do
        ret[v] = true
    end
    return ret
end

_G.termesc.setup = function (cfg)
    if cfg and cfg.key then
        _G.termesc.key = cfg.key
    else
        _G.termesc.key = '<Esc>'
    end
    if cfg and cfg.except then
        _G.termesc.except = set(cfg.except)
    else
        _G.termesc.except = {nvim = true}
    end
    vim.api.nvim_set_keymap('t', _G.termesc.key, 'v:lua.termesc.smart_esc(b:terminal_job_pid)', {noremap = true, expr = true})
end

return _G.termesc
