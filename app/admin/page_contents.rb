ActiveAdmin.register PageContent do
  permit_params :title, :slug, :content

  index do
    selectable_column
    id_column
    column :title
    column :slug
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :slug, input_html: { disabled: true } # Prevent editing the slug to maintain URL integrity
      f.input :content, as: :text
    end
    f.actions
  end
end
