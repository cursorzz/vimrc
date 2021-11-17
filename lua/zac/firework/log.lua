local log = require("structlog")

local logger =
  log.Logger(
  "firework.nvim",
  {
    log.sinks.Console(
      log.level.INFO,
      {
        processors = {
          log.processors.Namer(),
          log.processors.Timestamper("%H:%M:%S")
        },
        formatter = log.formatters.Format("%s [%s] %s: %-30s", {"timestamp", "level", "logger_name", "msg"}) --
      }
    )
  }
)

return logger
