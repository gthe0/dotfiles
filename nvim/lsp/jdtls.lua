local function get_mason_jdtls_path()
  return vim.fn.stdpath("data") .. "/mason/packages/jdtls"
end

local function get_launcher_jar(jdtls_path)
  return vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
end

local function get_config_dir(jdtls_path)
  local system = vim.loop.os_uname().sysname
  if system == "Linux" then
    return jdtls_path .. "/config_linux"
  elseif system == "Darwin" then
    return jdtls_path .. "/config_mac"
  else
    return jdtls_path .. "/config_win"
  end
end

local function get_workspace_dir(root_dir)
  local base = vim.fn.stdpath("data") .. "/jdtls-workspaces"
  local project = root_dir and vim.fn.fnamemodify(root_dir, ":p:h:t") or "default"
  return base .. "/" .. project
end

local root_markers = {
  ".git",
  "mvnw",
  "gradlew",
  "pom.xml",
  "build.gradle",
  "build.gradle.kts",
}

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local jdtls_path = get_mason_jdtls_path()
    local launcher = get_launcher_jar(jdtls_path)
    local config_dir = get_config_dir(jdtls_path)
    local workspace_dir = get_workspace_dir(config.root_dir)

    local cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.level=ALL",
      "-noverify",
      "-Xmx1G",
      "-jar", launcher,
      "-configuration", config_dir,
      "-data", workspace_dir,
    }

    return vim.lsp.rpc.start(cmd, dispatchers, {
      cwd = config.cmd_cwd,
      env = config.cmd_env,
      detached = config.detached,
    })
  end,

  filetypes = { "java" },

  root_markers = root_markers,

  init_options = {},
}

