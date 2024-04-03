class StaticPagesController < ApplicationController
  def about
    @content = PageContent.find_by(slug: 'about')
  end

  def contact
    @content = PageContent.find_by(slug: 'contact')
  end
end
