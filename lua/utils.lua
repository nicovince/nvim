function path_match_pattern(path, pattern)
  return string.match(path, pattern)
end
function IsZephyr()
  local path = vim.fn.expand('%:p')
  return path_match_pattern(path, 'zephyr')
end
