-- Номера строк
vim.opt.number = true
-- Первая строка всегда под курсором
vim.opt.relativenumber = true

-- Разделить рабочую область по горизонтали
vim.opt.splitbelow = true
-- Раздилить рабочую область по горизонтали
vim.opt.splitright = true

-- Отменить авто-перенос строк
vim.opt.wrap = false

-- Вставлять отступ при нажатии на tab
vim.opt.expandtab = true
-- ?
vim.opt.tabstop = 2
-- Размер отступа
vim.opt.shiftwidth = 2

-- Изспользовать внешний буфер обмена, наверное
vim.opt.clipboard = "unnamedplus"

-- Активная строка всегда по центру
vim.opt.scrolloff = 999

-- При переходе в жедим виделения по умолчанию выделяем всю строку при переходе вниз
vim.opt.virtualedit = "block"

-- ?
vim.opt.inccommand = "split"

-- Игнорировать регистр при поиске /
vim.opt.ignorecase = true

-- Минимальная подсветка синтаксиса
vim.opt.termguicolors = true

-- Настройка для auto-session
vim.o.sessionoptions="localoptions"

-- fold
vim.o.foldlevel = 20
vim.opt.foldlevelstart = 99
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

-- Клавиша-лидер
vim.g.mapleader = " "
-- ?
vim.g.maplocalleader = "\\"

-- Вызов файла с конфигом пакетного менеджера
require("config.lazy")
require("mappings")
