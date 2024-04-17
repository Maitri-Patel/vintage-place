ActiveAdmin.register Product do
  permit_params :name, :description, :price, :quantity_available, :category_id, :on_sale, :image
  
    index do
      selectable_column
      id_column
      column :name
      column :description
      column :price
      column :quantity_available
      column "Category", :category, sortable: :category_id

      # Add a column for image if it's attached
      column "Image" do |product|
      if product.image.attached?
         image_tag product.image.variant(resize_to_limit: [100, 100])
      else
         'No Image'
        end
      end




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

        # Add image upload field
        f.input :image, as: :file, hint: f.object.image.attached? ?
        image_tag(f.object.image, size: "200x200") : content_tag(:span, "No image available")

      end
      f.actions
    end
  end
  