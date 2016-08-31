csv = require 'csv'
json2csv = require 'json2csv'
moment = require 'moment'

fs = require 'fs'

filename = process.argv[2]

printUsage = ->
  console.log """
    ING Bank transaction report to Xero ISO 20022 bank statement converter
    -------------------------------------------------------------------------
    https://github.com/petrutoader/ingbrobu-xero
    -------------------------------------------------------------------------
    Usage: coffee run.coffee ~/Downloads/report.csv

  """

curate = (data) ->
  moment.locale 'ro'
  cleanupAmount = (amount) ->
    return amount.replace('.', '').replace(',', '.')

  curatedData = []
  transaction = {}

  data.forEach (item, index) ->
    if item[0] != ""

      curatedData.push transaction
      transaction = {}

      transaction.Date = moment(item[0], 'DD MMMM YYYY').format("DD/MM/YYYY")
      transaction.Description = item[1]

      if item[2] != ""
        transaction.Amount = +cleanupAmount(item[2]) * -1
      else
        transaction.Amount = +cleanupAmount(item[3])
    else
      transaction.Description += " " + item[1]
  return curatedData

cleanup = (data) ->
  data.shift()
  data.pop()
  data.pop()
  return data

return printUsage() if !filename?

data = fs.readFileSync filename

csv.parse data, (err, data) ->
  cleanup data
  console.log json2csv data: curate(data)
