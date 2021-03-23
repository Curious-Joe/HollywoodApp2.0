dollar <- scales::dollar_format(
  prefix = "$",
  suffix = "", 
  decimal.mark = ".",
  big.mark = ",", scale = 1/1000000
)

comma <- scales::comma_format(
  suffix = "m",
  decimal.mark = ".",
  big.mark = ",", scale = 1/1000000
)
