class SiteConfig
  cattr_accessor :race_types, :car_restrictions, :tyre_restrictions, :max_players
  @@race_types = ['Race for real', 'Race for fun', 'Drift', 'Free run']
  @@car_restrictions = ['No limit', 'Racing karts only', 'Ferrari F1 only', 'Select from garage']
  @@tyre_restrictions = ['No limit', 'Comfort: Hard', 'Comfort: Medium', 'Comfort: Soft', 'Sports: Hard', 'Sports: Medium', 'Sports: Soft', 'Racing: Hard', 'Racing: Medium', 'Racing: Soft']
  @@max_players = (2..16).to_a
end