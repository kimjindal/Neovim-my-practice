local status_ok, surround = pcall(require, "surround")
if not status_ok then
  return
end

surround.setup {
  context_offset = 100,
  load_autogroups = false,
  mappings_style = "surround", -- sandwich/surround
  map_insert_mode = false,
  quotes = { "'", '"' },
  brackets = { "(", "{", "[" },
  space_on_closing_char = false,
  pairs = {
    nestable = { { "(", ")" }, { "[", "]" }, { "{", "}" } },
    linear = { { "'", "'" }, { "`", "`" }, { '"', '"' } },
  },
  prefix = "s",
}
