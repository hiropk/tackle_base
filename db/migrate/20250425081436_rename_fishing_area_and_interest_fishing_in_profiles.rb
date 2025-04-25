class RenameFishingAreaAndInterestFishingInProfiles < ActiveRecord::Migration[8.0]
  def change
    rename_column :profiles, :fishing_area, :fishing_areas
    rename_column :profiles, :interest_fishing, :interest_fishings
  end
end
