ActiveAdmin.register Order do
  # Setting the menu order or position
  menu priority: 4

  # Permitting parameters for safe handling
  permit_params :user_id, :total_price, :tax_amount, :created_at

  # Custom index table
  index do
    selectable_column
    id_column
    column :user
    column :total_price
    column :tax_amount
    column :created_at
    actions
  end

  # Filters to refine the orders displayed
  filter :user
  filter :total_price
  filter :tax_amount
  filter :created_at

  # Show page for an individual order
  show do
    attributes_table do
      row :user
      row :total_price
      row :tax_amount
      row :created_at
    end

    panel "Items" do
      table_for order.order_tracks do
        column "Product", :product
        column "Quantity", :quantity
        column "Price at Purchase", :price_at_purchase
      end
    end
  end

  # Form configuration for editing (if needed)
  form do |f|
    f.inputs do
      f.input :user
      f.input :total_price
      f.input :tax_amount
      f.input :created_at, as: :datepicker
    end
    f.actions
  end
end
