module DefaultPageContent
  extend ActiveSupport::Concern

  included do
    before_action :set_page_defaults
  end

  def set_page_defaults
    @mom_name = ENV.has_key?('MOM_NAME') ? ENV.fetch('MOM_NAME') : "ChangeMe Mom"
    @child_name = ENV.has_key?('CHILD_NAME') ? ENV.fetch('CHILD_NAME') : 'ChangeMe Child'
    @site_title = ENV.has_key?('SITE_TITLE') ? ENV.fetch('SITE_TITLE') : "#{@child_name}'s Photo Site"
    @background_image = ENV.has_key?('BACKGROUND_IMAGE') ? ENV.fetch('BACKGROUND_IMAGE') : 'https://s3.amazonaws.com/cb-general/baby-playing-on-beach.jpg'
    @email_prefix = ENV.has_key?('EMAIL_PREFIX') ? ENV.fetch('EMAIL_PREFIX') : 'ChangeMe'
    @admin_name = ENV.has_key?('ADMIN_NAME') ? ENV.fetch('ADMIN_NAME') : 'ChangeMe Admin'
    @admin_email = ENV.has_key?('ADMIN_EMAIL') ? ENV.fetch('ADMIN_EMAIL') : 'changeme@example.com'
    @support_email = ENV.has_key?('SUPPORT_EMAIL') ? ENV.fetch('SUPPORT_EMAIL') : 'changeme@example.com'
    @developer_name = ENV.has_key?('DEVELOPER_NAME') ? ENV.fetch('DEVELOPER_NAME') : 'Chazona Baum'
    @developer_url = ENV.has_key?('DEVELOPER_URL') ? ENV.fetch('DEVELOPER_URL') : 'https://chazonabaum.com'
  end
end