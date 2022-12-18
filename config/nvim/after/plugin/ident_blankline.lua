local ok, ident_blackline = pcall(require, 'ident_blackline')
if not ok then return end

ident_blackline.setup {}
