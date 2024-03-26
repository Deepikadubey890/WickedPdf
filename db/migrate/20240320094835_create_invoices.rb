class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :full_name
      t.string :address
      t.string :name
      t.string :email
      t.string :phone
      t.string :status
      t.decimal :discount
      t.decimal :vat

      t.timestamps
    end
  end
end
