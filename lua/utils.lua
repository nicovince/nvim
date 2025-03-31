function path_match_pattern(path, pattern)
  local result = string.match(path, pattern)
  return result
end

function IsZephyr(path)
  return path_match_pattern(path, 'zephyr')
end

function IsLinux(path)
  local res = path_match_pattern(path, 'linux') or path_match_pattern(path, 'lkm')
  return res
end

function IsSiema(path)
  local res = path_match_pattern(path, 'work/siema')
  return res
end
