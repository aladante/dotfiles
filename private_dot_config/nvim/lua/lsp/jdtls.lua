local home = os.getenv 'HOME'
local jdtls = require 'jdtls'
local root_markers = { 'gradlew', 'mvnw', '.git' }
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_dir = vim.fn.fnamemodify(root_dir, ':p:h:t')

local remap = require('me.util').remap

local finders = require 'telescope.finders'
local sorters = require 'telescope.sorters'
local actions = require 'telescope.actions'
local pickers = require 'telescope.pickers'
local action_state = require 'telescope.actions.state'
local share_dir = os.getenv 'HOME' .. '/.local/share'

local M = {}

-- LOCAL FUNCS for java debugging
function Get_test_runner(test_name, debug)
  if debug then
    return 'mvn test -Dmaven.surefire.debug -Dtest="' .. test_name .. '"'
  end
  return 'mvn test -Dtest="' .. test_name .. '"'
end

function Run_java_test_method(debug)
  local utils = require 'utils'
  local method_name = utils.get_current_full_method_name '\\#'
  vim.cmd('term ' .. Get_test_runner(method_name, debug))
end

function Run_java_test_class(debug)
  local utils = require 'utils'
  local class_name = utils.get_current_full_class_name()
  vim.cmd('term ' .. Get_test_runner(class_name, debug))
end

function Get_spring_boot_runner(profile, debug)
  local debug_param = ''
  if debug then
    debug_param =
    ' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
  end

  local profile_param = ''
  if profile then
    profile_param = ' -Dspring-boot.run.profiles=' .. profile .. ' '
  end

  return 'mvn spring-boot:run ' .. profile_param .. debug_param
end

function Attach_to_debug()
  local dap = require 'dap'
  dap.configurations.java = {
    {
      type = 'java',
      request = 'attach',
      name = 'Attach to the process',
      hostName = 'localhost',
      port = '5005',
    },
  }
  dap.continue()
end

function Run_spring_boot(debug)
  vim.cmd('term ' .. Get_spring_boot_runner('local', debug))
end

local on_attach = function(client, bufnr)
  jdtls.setup_dap { hotcodereplace = 'auto' }
  jdtls.setup.add_commands()

  -- Default keymaps
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  require('lsp.defaults').on_attach(client, bufnr)

  -- Java extensions
  remap('n', '<C-o>', jdtls.organize_imports, bufopts, 'Organize imports')
  remap('n', '<leader>vc', jdtls.test_class, bufopts, 'Test class (DAP)')
  remap('n', '<leader>vm', jdtls.test_nearest_method, bufopts, 'Test method (DAP)')
  remap('n', '<space>ev', jdtls.extract_variable, bufopts, 'Extract variable')
  remap('n', '<space>ec', jdtls.extract_constant, bufopts, 'Extract constant')
  remap('v', '<space>em', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], bufopts, 'Extract method')

  -- RUN DEBUG Java

  remap('n', '<leader>tm', function()
    Run_java_test_method()
  end, bufopts, 'Java test')
  remap('n', '<leader>TM', function()
    Run_java_test_method(true)
  end, bufopts, 'java test method')
  remap('n', '<leader>tc', function()
    Run_java_test_class()
  end, bufopts, 'Java test class')
  remap('n', '<leader>TC', function()
    Run_java_test_class(true)
  end, bufopts, 'java test class')
  remap('n', '<F9>', function()
    Run_spring_boot()
  end, bufopts, 'java run')
  remap('n', '<F10>', function()
    Run_spring_boot(true)
  end, bufopts, 'java run debug')
end

local bundles = {
  vim.fn.glob(share_dir .. '/java/dependencies/com.microsoft.java.debug.plugin-*.jar'),
}
vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(share_dir .. '/nvim/debug_extensions/vscode-java-test/server/*.jar'), '\n')
)

function M.setup()
  local lombokjar = share_dir .. '/java/dependencies/lombok.jar'
  local config = {
    flags = {
      -- allow_incremental_sync = true,
      server_side_fuzzy_completion = true,
    },
    -- capabilities = java.lsp.capabilities,
    -- on_attach = java.lsp.on_attach,
  }

  local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  config.init_options = {
    extendedClientCapabilities = extendedClientCapabilities,
    bundles = {
      vim.fn.glob(
        home
        .. '/.local/share/dap/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'
      ),
    },
  }

  config.settings = {
    -- ['java.format.settings.url'] = home .. '/.config/nvim/language-servers/java-google-formatter.xml',
    -- ['java.format.settings.profile'] = 'GoogleStyle',
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          -- 'org.hamcrest.MatcherAssert.assertThat',
          -- 'org.hamcrest.Matchers.*',
          -- 'org.hamcrest.CoreMatchers.*',
          -- 'org.junit.jupiter.api.Assertions.*',
          -- 'java.util.Objects.requireNonNull',
          -- 'java.util.Objects.requireNonNullElse',
          -- 'org.mockito.Mockito.*',
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        generatpComments = true,
        -- toStrinvag = {
        --     template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
        -- },
      },
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-11',
            path = '/usr/lib/jvm/java-11-openjdk-amd64/',
          },
          { name = 'JavaSE-17', path = '/usr/lib/jvm/java-17-openjdk-amd64/' },
        },
      },
    },
  }

  -- config.cmd = { 'java-lsp.sh', workspace_folder }

  config.cmd = {
    -- 💀
    'jdtls', -- or '/path/to/java11_or_newer/bin/java'
    -- See `data directory configuration` section in the README
    '--jvm-arg=-javaagent:' .. lombokjar,
    '-data',
    vim.fn.expand '~/.cache/jdtls-workspace' .. workspace_dir,
  }
  config.root_dir = require('jdtls.setup').find_root {
    '.git',
    'mvnw',
    'gradlew',
    'pom.xml',
  }
  config.on_attach = on_attach
  config.on_init = function(client, _)
    client.notify('workspace/didChangeConfiguration', { settings = config.settings })
  end

  require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
    local opts = {}
    pickers.new(opts, {
      prompt_title = prompt,
      finder = finders.new_table {
        results = items,
        entry_maker = function(entry)
          return {
            value = entry,
            display = label_fn(entry),
            ordinal = label_fn(entry),
          }
        end,
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          cb(selection.value)
        end)

        return true
      end,
    }):find()
  end
  -- Server
  require('jdtls').start_or_attach(config)
end

return M
