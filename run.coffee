filename = process.argv[2]

printUsage = ->
  console.log """
    INGBROBU to Xero convertor
    --------------------------------------------------
    More warez @ https://github.com/petrutoader/ingbrobu-xero
    Usage:
      coffee run.coffee ~/Downloads/report.csv

  """

return printUsage() if !filename?
