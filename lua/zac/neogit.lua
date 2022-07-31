local exist, neogit = pcall(require, "neogit")
if exist then
  neogit.setup({
    disable_commit_confirmation = true,
    sections = {
      untracked = {
        folded = true
      },
      recent =  {
        folded = false
      }
    }


    -- mappings = {
    --   status = {
    --     ["-"] = "Stage"
    --   }
    -- }
  })
end


