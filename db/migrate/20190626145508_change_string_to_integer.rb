class ChangeStringToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column(:invoice_items, :quantity, 'bigint USING CAST(quantity AS bigint)')
    change_column(:invoice_items, :unit_price, 'bigint USING CAST(unit_price AS bigint)')
    change_column(:items, :unit_price, 'bigint USING CAST(unit_price AS bigint)')
  end
end
