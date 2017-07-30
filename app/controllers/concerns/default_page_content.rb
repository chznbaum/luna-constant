module DefaultPageContent
  extend ActiveSupport::Concern

  included do
    before_action :set_page_defaults
  end

  def set_page_defaults
    @mom_name = "Default Name"
    @child_name = "Change Me"
    @site_title = "#{@child_name}'s Photo Site"
    @page_title = ""
  end
end