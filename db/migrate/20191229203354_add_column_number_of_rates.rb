class AddColumnNumberOfRates < ActiveRecord::Migration[5.2]
  def change
    add_column(:songs, :number_of_rates, :integer)
  end
end
