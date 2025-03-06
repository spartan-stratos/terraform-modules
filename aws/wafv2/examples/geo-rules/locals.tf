locals {
  # Define allowed countries and blocked regions
  allowed_countries = var.environment == "prod" ? [
    "US",  # United States
    "CA"   # Canada
  ] : [
    "US",  # United States
    "CA",  # Canada
    "VN",  # Vietnam
    "UA"  # Ukraine
  ]

  # Blocked regions
  blocked_regions = []

  # blocked_regions = [
  #   "US-AZ",  # Arizona
  #   "US-IA",  # Iowa
  #   "US-VT",  # Vermont
  #   "US-MI",  # Michigan
  #   "US-DE",  # Delaware
  #   "US-MD",  # Maryland
  #   "US-AR",  # Arkansas
  #   "US-LA",  # Louisiana
  #   "US-VA",  # Virginia
  #   "US-FL",  # Florida
  #   "US-SC"   # South Carolina
  # ]

  #

  # Dynamically generate geo_rules
  geo_rules = concat(
    # Rule to label allowed countries
    [{
      name          = "label-allowed-countries"
      priority      = 10
      action        = "count"
      type          = "geo_match"
      country_codes = local.allowed_countries
      label_keys    = []
    }],
    # Rule to block requests not from allowed countries
    [{
      name          = "block-non-allowed-countries"
      priority      = 20
      action        = "block"
      type          = "not_labels"
      country_codes = []
      label_keys    = [for country in local.allowed_countries : "awswaf:clientip:geo:country:${country}"]
    }],
    # Rules to block specific regions
    [for idx, region in local.blocked_regions : {
      name          = "block-${lower(region)}"
      priority      = 30 + idx
      action        = "block"
      type          = "label_match"
      country_codes = []
      label_keys    = ["awswaf:clientip:geo:region:${region}"]
    }]
  )
}
