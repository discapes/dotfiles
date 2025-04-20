os_result = vim.fn.system({"sh", "-c", "cat /etc/*-release | rg '^NAME=(.*)' -or '$1' | tr -d '\n'"})
is_nixos = string.lower(os_result) == "nixos"
print("nixos: " ..  tostring(is_nixos))

return {
    "williamboman/mason.nvim",
    enabled = not is_nixos
}
