class SiteConfig
  cattr_accessor :race_types, :car_restrictions, :tyre_restrictions, :max_players, :mechanical, :game_mode, :penalties, :start_type, :type_fuel_dep, :grid_order, :boost, :shuffle_ratio, :grip_reduction, :laps
  # race regulations
  @@race_types = ['Race for real', 'Race for fun', 'Drift', 'Free run']
  @@car_restrictions = ['No limit', 'Racing karts only', 'Ferrari F1 only', 'Select from garage']
  @@tyre_restrictions = ['No limit', 'Comfort: Hard', 'Comfort: Medium', 'Comfort: Soft', 'Sports: Hard', 'Sports: Medium', 'Sports: Soft', 'Racing: Hard', 'Racing: Medium', 'Racing: Soft']
  @@max_players = (2..16).to_a
  @@laps = (1..200).to_a
  # event settings
  @@mechanical = ['None', 'Light', 'Heavy']
  @@game_mode = ['Normal race', 'Shuffle race']
  @@penalties = ['None', 'Weak', 'Strong']
  @@start_type = ['Grid start', 'Grid start with false start check']
  @@type_fuel_dep = ['On', 'Off']
  @@grid_order = ['Fastest', 'Slowest', 'Reverse grid based on previous race results']
  @@boost = ['None', 'Low', 'High']
  @@shuffle_ratio = (0..10).to_a
  @@grip_reduction = ['Low', 'High']
end