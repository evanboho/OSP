class Setting < ActiveRecord::Base
  attr_accessible :page, :settings_hash, :link, :tagline, :name, :notifier_email

  serialize :settings_hash, Hash
  
  # before_validation :clean_up_link
  # validate :link_starts_with_http
  # validate :page, :length => { :maxmimum => 4 }

  scope :resources, where(:page => "resources")
  scope :settings, where(:page => "settings")
  scope :contact_us, where(:page => "contact_us")

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
      # link = http_link
    end


end
