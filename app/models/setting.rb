class Setting < ActiveRecord::Base
  serialize :settings_hash, Hash

  %w(resources settings contact_us).each do |page|
    scope page.to_sym, -> { where(page: page) }
  end

  def notifier_email
    self.settings_hash[:email]
  end

  def notifier_email=(value)
    self.settings_hash[:email] = value.to_s
    self.page = "contact_us"
  end

  def name
    self.settings_hash[:name]
  end

  def name=(value)
    self.settings_hash[:name] = value.to_s
    self.page = "resources"
  end

  def link
    self.settings_hash[:link]
  end

  def link=(value)
    value = clean_up_link(value)
    self.settings_hash[:link] = value.to_s
    self.page = "resources"
  end

  def tagline
    self.settings_hash[:tagline]
  end

  def tagline=(value)
    self.settings_hash[:tagline] = value.to_s
    self.page = "resources"
  end

  private
    def link_starts_with_http
      if link.to(3) != "http"
        errors.add(:link, "It should start with http")
      end
    end

    def clean_up_link(value)
      return value if value.to(3) == "http"
      http_link = "http://" + value
    end


end
