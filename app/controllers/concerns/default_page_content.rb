module DefaultPageContent
  extend ActiveSupport::Concern

  included do
    before_action :set_page_defaults
  end

  def set_page_defaults
    @mom_name = "Tatiana Constant"
    @child_name = "Luna Constant"
    @site_title = "#{@child_name}'s Photo Site"
  end
end