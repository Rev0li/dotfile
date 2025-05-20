local M = {}

-- Centrage horizontal basé sur la largeur de la fenêtre active
function M.center_text(str)
	-- On utilise la largeur totale de l'écran (plus stable au démarrage)
	local width = 25 
	local pad = math.floor((width - vim.fn.strchars(str)) / 2)
	return string.rep(" ", math.max(pad, 0)) .. str
end


return M

