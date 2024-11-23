--Bootstrap file for setting up the repository
--
--
--
-- Change the path to clone into ~/.config/nvim/lazy/nvim_conf
local lazypath = vim.fn.stdpath("config") .. "/lua/nvim_conf"  -- This points to ~/.config/nvim/lazy

-- Check if the path exists, and if not, clone the repo
if not vim.loop.fs_stat(lazypath) then
  print("Cloning custom Neovim config...")
  vim.fn.system({
    "git",
    "clone",
    "--depth=1",
    "git@github.com:AlexandreDoucet/nvim_conf.git",
    lazypath,
  })
end

-- Prepend the path to 'nvim_conf' to the runtime path
vim.opt.rtp:prepend(lazypath)

-- Attempt to load the custom config
local ok, err = pcall(require, "nvim_conf")
if not ok then
  print("Error loading custom config: " .. err)
else
  print("Successfully loaded custom config!")
end





-- Auto updates the configuration from the github repository
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.loop.spawn("git", {
      args = { "-C", lazypath, "pull" },
      stdout = vim.loop.new_pipe(false),
      stderr = vim.loop.new_pipe(false),
      on_exit = function(_, code, _)
        if code == 0 then
          -- Capture the output to check if changes occurred
          local stdout = vim.loop.new_pipe(false)
          local stderr = vim.loop.new_pipe(false)
          local output = ""

          -- Listen for output and append it
          stdout:read_start(function(err, chunk)
            if err then
              print("Error reading stdout: " .. err)
              return
            end
            if chunk then
              output = output .. chunk
            end
          end)

          stderr:read_start(function(err, chunk)
            if err then
              print("Error reading stderr: " .. err)
              return
            end
            if chunk then
              output = output .. chunk
            end
          end)

          -- Check the output for change indications
          if output:find("Updating") or output:find("Fast-forward") then
            -- Reload Neovim if there were changes
            print("Changes detected, reloading Neovim...")
            vim.cmd("source $MYVIMRC")  -- Reload the Neovim configuration
          else
            print("No changes detected.")
          end
        else
          print("Error pulling changes.")
        end
      end
    })
  end,
})
