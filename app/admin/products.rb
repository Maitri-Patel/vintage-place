ActiveAdmin.register Product do
  permit_params :name, :description, :price, :quantity_available, :category_id, :on_sale
  
    index do
      selectable_column
      id_column
      column :name
      column :description
      column :price
      column :quantity_available
      column "Category", :category, sortable: :category_id
      actions
    end
  
    filter :name
    filter :category
    filter :price
  
    form do |f|
      f.inputs do
        f.input :name
        f.input :description
        f.input :price
        f.input :quantity_available
        f.input :on_sale
        f.input :category, as: :select, collection: Category.all.map { |c| [c.name, c.id] }
      end
      f.actions
    end
  end
  